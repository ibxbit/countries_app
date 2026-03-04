import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/failures.dart';
import '../datasources/detail_remote_data_source.dart';
import '../models/country_detail_model.dart';
import '../models/country_detail_seed_model.dart';
import '../../domain/entities/country_detail.dart';
import '../../domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDataSource remoteDataSource;
  final Box<String> cacheBox;
  final Box<String> countriesCacheBox;

  static const String _allCountriesCacheKey = 'all_countries';
  static const String _allCountriesDetailSeedCacheKey =
      'all_countries_detail_seed';

  DetailRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheBox,
    required this.countriesCacheBox,
  });

  Future<void> _cacheCountryDetail(
    String code,
    CountryDetailModel model,
  ) async {
    await cacheBox.put(code, jsonEncode(model.toJson()));
  }

  CountryDetailModel? _readCachedCountryDetail(String code) {
    final cached = cacheBox.get(code);
    if (cached == null || cached.isEmpty) {
      return null;
    }
    return CountryDetailModel.fromJson(
      Map<String, dynamic>.from(jsonDecode(cached) as Map),
    );
  }

  CountryDetail? _readFallbackCountryDetailFromSummary(String code) {
    final cachedCountries = countriesCacheBox.get(_allCountriesCacheKey);
    if (cachedCountries == null || cachedCountries.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(cachedCountries) as List<dynamic>;
    final match = decoded.cast<Map>().firstWhere(
      (item) =>
          ((item['cca2'] as String?)?.toUpperCase() ?? '') ==
          code.toUpperCase(),
      orElse: () => <String, dynamic>{},
    );

    if (match.isEmpty) {
      return null;
    }

    final map = Map<String, dynamic>.from(match);
    final name = Map<String, dynamic>.from(map['name'] as Map? ?? {});
    final flags = Map<String, dynamic>.from(map['flags'] as Map? ?? {});
    final capitals = (map['capital'] as List?)?.cast<dynamic>() ?? [];

    return CountryDetail(
      cca2: (map['cca2'] as String?) ?? code,
      commonName: (name['common'] as String?) ?? 'Unknown',
      flagPng: (flags['png'] as String?) ?? '',
      flagSvg: (flags['svg'] as String?) ?? '',
      population: (map['population'] as int?) ?? 0,
      capital: capitals.isNotEmpty
          ? (capitals.first as String? ?? 'N/A')
          : 'N/A',
      region: 'N/A',
      subregion: 'N/A',
      area: 0,
      timezones: const [],
    );
  }

  CountryDetail? _readFallbackCountryDetailFromSeed(String code) {
    final cachedSeed = countriesCacheBox.get(_allCountriesDetailSeedCacheKey);
    if (cachedSeed == null || cachedSeed.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(cachedSeed) as List<dynamic>;
    Map<String, dynamic>? match;
    for (final item in decoded) {
      final map = Map<String, dynamic>.from(item as Map);
      final cca2 = (map['cca2'] as String?)?.toUpperCase() ?? '';
      if (cca2 == code.toUpperCase()) {
        match = map;
        break;
      }
    }

    if (match == null) {
      return null;
    }

    final seed = CountryDetailSeedModel.fromJson(match);
    return CountryDetail(
      cca2: seed.cca2,
      commonName: seed.commonName,
      flagPng: seed.flagPng,
      flagSvg: seed.flagSvg,
      population: seed.population,
      capital: seed.capital,
      region: seed.region,
      subregion: seed.subregion,
      area: seed.area,
      timezones: seed.timezones,
    );
  }

  @override
  Future<Either<Failure, CountryDetail>> getCountryDetail(String code) async {
    try {
      final remoteCountry = await remoteDataSource.getCountryDetail(code);
      await _cacheCountryDetail(code, remoteCountry);
      return Right(remoteCountry.toEntity());
    } catch (e) {
      final cachedCountry = _readCachedCountryDetail(code);
      if (cachedCountry != null) {
        return Right(cachedCountry.toEntity());
      }
      final seededCountry = _readFallbackCountryDetailFromSeed(code);
      if (seededCountry != null) {
        return Right(seededCountry);
      }
      final fallbackCountry = _readFallbackCountryDetailFromSummary(code);
      if (fallbackCountry != null) {
        return Right(fallbackCountry);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'dart:convert';
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:countries_app/features/home/data/models/country_summary_model.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final Box<String> cacheBox;

  static const String _allCountriesCacheKey = 'all_countries';
  static const String _allCountriesDetailSeedCacheKey =
      'all_countries_detail_seed';

  HomeRepositoryImpl({required this.remoteDataSource, required this.cacheBox});

  Future<void> _cacheCountries(List<CountrySummaryModel> countries) async {
    final payload = jsonEncode(
      countries.map((country) => country.toJson()).toList(),
    );
    await cacheBox.put(_allCountriesCacheKey, payload);
  }

  Future<void> _cacheDetailSeed(List<Map<String, dynamic>> detailSeed) async {
    final payload = jsonEncode(detailSeed);
    await cacheBox.put(_allCountriesDetailSeedCacheKey, payload);
  }

  Future<void> _prefetchFlagImages(List<CountrySummaryModel> countries) async {
    final cacheManager = DefaultCacheManager();
    for (final country in countries) {
      final flagPng = country.flags?['png'] as String?;
      if (flagPng == null || flagPng.isEmpty) continue;
      try {
        await cacheManager.downloadFile(flagPng);
      } catch (_) {}
    }
  }

  List<CountrySummaryModel> _readCachedCountries() {
    final cached = cacheBox.get(_allCountriesCacheKey);
    if (cached == null || cached.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(cached) as List<dynamic>;
    return decoded
        .map(
          (item) => CountrySummaryModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  @override
  Future<Either<Failure, List<CountrySummary>>> getAllCountries() async {
    try {
      final remoteCountries = await remoteDataSource.getAllCountries();
      await _cacheCountries(remoteCountries);
      final detailSeed = await remoteDataSource.getAllCountriesDetailSeed();
      if (detailSeed.isNotEmpty) {
        await _cacheDetailSeed(detailSeed);
      }
      unawaited(_prefetchFlagImages(remoteCountries));
      return Right(remoteCountries.map((e) => e.toEntity()).toList());
    } catch (e) {
      final cachedCountries = _readCachedCountries();
      if (cachedCountries.isNotEmpty) {
        return Right(cachedCountries.map((e) => e.toEntity()).toList());
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CountrySummary>>> searchCountries(
    String name,
  ) async {
    try {
      final remoteCountries = await remoteDataSource.searchCountries(name);
      return Right(remoteCountries.map((e) => e.toEntity()).toList());
    } catch (e) {
      final cachedCountries = _readCachedCountries();
      if (cachedCountries.isNotEmpty) {
        final filtered = cachedCountries.where((country) {
          final commonName =
              (country.name != null
                      ? (country.name!['common'] as String?)
                      : null)
                  ?.toLowerCase() ??
              '';
          return commonName.contains(name.toLowerCase());
        }).toList();
        return Right(filtered.map((country) => country.toEntity()).toList());
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}

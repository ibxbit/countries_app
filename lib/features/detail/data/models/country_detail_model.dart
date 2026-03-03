import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/country_detail.dart';

part 'country_detail_model.freezed.dart';
part 'country_detail_model.g.dart';

@freezed
class CountryDetailModel with _$CountryDetailModel {
  const factory CountryDetailModel({
    required String? cca2,
    required Map<String, dynamic>? name,
    required Map<String, dynamic>? flags,
    required int? population,
    required List<dynamic>? capital,
    required String? region,
    required String? subregion,
    required double? area,
    required List<String>? timezones,
  }) = _CountryDetailModel;

  factory CountryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CountryDetailModelFromJson(json);

  const CountryDetailModel._();

  CountryDetail toEntity() {
    return CountryDetail(
      cca2: cca2 ?? '??',
      commonName:
          (name != null ? (name!['common'] as String?) : null) ?? 'Unknown',
      flagPng: (flags != null ? (flags!['png'] as String?) : null) ?? '',
      flagSvg: (flags != null ? (flags!['svg'] as String?) : null) ?? '',
      population: population ?? 0,
      capital: (capital != null && capital!.isNotEmpty)
          ? (capital!.first as String?) ?? 'N/A'
          : 'N/A',
      region: region ?? 'N/A',
      subregion: subregion ?? 'N/A',
      area: area ?? 0.0,
      timezones: timezones ?? [],
    );
  }
}

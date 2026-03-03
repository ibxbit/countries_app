import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';

part 'country_summary_model.freezed.dart';
part 'country_summary_model.g.dart';

@freezed
@HiveType(typeId: 0)
class CountrySummaryModel with _$CountrySummaryModel {
  const factory CountrySummaryModel({
    @HiveField(0) required Map<String, dynamic>? name,
    @HiveField(1) required Map<String, dynamic>? flags,
    @HiveField(2) required int? population,
    @HiveField(3) required String? cca2,
    @HiveField(4) required List<dynamic>? capital,
  }) = _CountrySummaryModel;

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$CountrySummaryModelFromJson(json);

  const CountrySummaryModel._();

  CountrySummary toEntity() {
    return CountrySummary(
      commonName:
          (name != null ? (name!['common'] as String?) : null) ?? 'Unknown',
      flagPng: (flags != null ? (flags!['png'] as String?) : null) ?? '',
      flagSvg: (flags != null ? (flags!['svg'] as String?) : null) ?? '',
      population: population ?? 0,
      cca2: cca2 ?? '??',
      capital: (capital != null && capital!.isNotEmpty)
          ? (capital!.first as String?) ?? 'N/A'
          : 'N/A',
    );
  }
}

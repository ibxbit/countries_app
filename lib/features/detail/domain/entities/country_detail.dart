import 'package:equatable/equatable.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';

class CountryDetail extends Equatable {
  final String cca2;
  final String commonName;
  final String flagPng;
  final String flagSvg;
  final int population;
  final String capital;
  final String region;
  final String subregion;
  final double area;
  final List<String> timezones;

  const CountryDetail({
    required this.cca2,
    required this.commonName,
    required this.flagPng,
    required this.flagSvg,
    required this.population,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.timezones,
  });

  CountrySummary toSummary() {
    return CountrySummary(
      cca2: cca2,
      commonName: commonName,
      flagPng: flagPng,
      flagSvg: flagSvg,
      population: population,
      capital: capital,
    );
  }

  @override
  List<Object?> get props => [
        cca2,
        commonName,
        flagPng,
        flagSvg,
        population,
        capital,
        region,
        subregion,
        area,
        timezones,
      ];
}

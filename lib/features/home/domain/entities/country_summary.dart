import 'package:equatable/equatable.dart';

class CountrySummary extends Equatable {
  final String commonName;
  final String flagPng;
  final String flagSvg;
  final int population;
  final String cca2;
  final String capital;

  const CountrySummary({
    required this.commonName,
    required this.flagPng,
    required this.flagSvg,
    required this.population,
    required this.cca2,
    required this.capital,
  });

  @override
  List<Object?> get props => [
    commonName,
    flagPng,
    flagSvg,
    population,
    cca2,
    capital,
  ];
}

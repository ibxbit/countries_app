class CountryDetailSeedModel {
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

  const CountryDetailSeedModel({
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

  factory CountryDetailSeedModel.fromJson(Map<String, dynamic> json) {
    final name = Map<String, dynamic>.from(json['name'] as Map? ?? {});
    final flags = Map<String, dynamic>.from(json['flags'] as Map? ?? {});
    final capitals = (json['capital'] as List?)?.cast<dynamic>() ?? [];
    final tz = (json['timezones'] as List?)?.cast<dynamic>() ?? [];

    return CountryDetailSeedModel(
      cca2: (json['cca2'] as String?) ?? '??',
      commonName: (name['common'] as String?) ?? 'Unknown',
      flagPng: (flags['png'] as String?) ?? '',
      flagSvg: (flags['svg'] as String?) ?? '',
      population: (json['population'] as int?) ?? 0,
      capital: capitals.isNotEmpty ? (capitals.first as String? ?? 'N/A') : 'N/A',
      region: (json['region'] as String?) ?? 'N/A',
      subregion: (json['subregion'] as String?) ?? 'N/A',
      area: (json['area'] as num?)?.toDouble() ?? 0,
      timezones: tz.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cca2': cca2,
      'name': {
        'common': commonName,
      },
      'flags': {
        'png': flagPng,
        'svg': flagSvg,
      },
      'population': population,
      'capital': [capital],
      'region': region,
      'subregion': subregion,
      'area': area,
      'timezones': timezones,
    };
  }
}

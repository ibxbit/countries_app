part of 'country_detail_model.dart';

// JsonSerializableGenerator

_$CountryDetailModelImpl _$$CountryDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CountryDetailModelImpl(
      cca2: json['cca2'] as String?,
      name: json['name'] as Map<String, dynamic>?,
      flags: json['flags'] as Map<String, dynamic>?,
      population: (json['population'] as num?)?.toInt(),
      capital: json['capital'] as List<dynamic>?,
      region: json['region'] as String?,
      subregion: json['subregion'] as String?,
      area: (json['area'] as num?)?.toDouble(),
      timezones: (json['timezones'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CountryDetailModelImplToJson(
        _$CountryDetailModelImpl instance) =>
    <String, dynamic>{
      'cca2': instance.cca2,
      'name': instance.name,
      'flags': instance.flags,
      'population': instance.population,
      'capital': instance.capital,
      'region': instance.region,
      'subregion': instance.subregion,
      'area': instance.area,
      'timezones': instance.timezones,
    };

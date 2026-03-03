part of 'country_summary_model.dart';

// TypeAdapterGenerator

class CountrySummaryModelAdapter extends TypeAdapter<CountrySummaryModel> {
  @override
  final int typeId = 0;

  @override
  CountrySummaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountrySummaryModel(
      name: (fields[0] as Map?)?.cast<String, dynamic>(),
      flags: (fields[1] as Map?)?.cast<String, dynamic>(),
      population: fields[2] as int?,
      cca2: fields[3] as String?,
      capital: (fields[4] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CountrySummaryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.flags)
      ..writeByte(2)
      ..write(obj.population)
      ..writeByte(3)
      ..write(obj.cca2)
      ..writeByte(4)
      ..write(obj.capital);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountrySummaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// JsonSerializableGenerator

_$CountrySummaryModelImpl _$$CountrySummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CountrySummaryModelImpl(
      name: json['name'] as Map<String, dynamic>?,
      flags: json['flags'] as Map<String, dynamic>?,
      population: (json['population'] as num?)?.toInt(),
      cca2: json['cca2'] as String?,
      capital: json['capital'] as List<dynamic>?,
    );

Map<String, dynamic> _$$CountrySummaryModelImplToJson(
        _$CountrySummaryModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'flags': instance.flags,
      'population': instance.population,
      'cca2': instance.cca2,
      'capital': instance.capital,
    };

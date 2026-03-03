part of 'country_detail_model.dart';

// FreezedGenerator

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CountryDetailModel _$CountryDetailModelFromJson(Map<String, dynamic> json) {
  return _CountryDetailModel.fromJson(json);
}

/// @nodoc
mixin _$CountryDetailModel {
  String? get cca2 => throw _privateConstructorUsedError;
  Map<String, dynamic>? get name => throw _privateConstructorUsedError;
  Map<String, dynamic>? get flags => throw _privateConstructorUsedError;
  int? get population => throw _privateConstructorUsedError;
  List<dynamic>? get capital => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get subregion => throw _privateConstructorUsedError;
  double? get area => throw _privateConstructorUsedError;
  List<String>? get timezones => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CountryDetailModelCopyWith<CountryDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryDetailModelCopyWith<$Res> {
  factory $CountryDetailModelCopyWith(
    CountryDetailModel value,
    $Res Function(CountryDetailModel) then,
  ) = _$CountryDetailModelCopyWithImpl<$Res, CountryDetailModel>;
  @useResult
  $Res call({
    String? cca2,
    Map<String, dynamic>? name,
    Map<String, dynamic>? flags,
    int? population,
    List<dynamic>? capital,
    String? region,
    String? subregion,
    double? area,
    List<String>? timezones,
  });
}

/// @nodoc
class _$CountryDetailModelCopyWithImpl<$Res, $Val extends CountryDetailModel>
    implements $CountryDetailModelCopyWith<$Res> {
  _$CountryDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cca2 = freezed,
    Object? name = freezed,
    Object? flags = freezed,
    Object? population = freezed,
    Object? capital = freezed,
    Object? region = freezed,
    Object? subregion = freezed,
    Object? area = freezed,
    Object? timezones = freezed,
  }) {
    return _then(
      _value.copyWith(
            cca2: freezed == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            flags: freezed == flags
                ? _value.flags
                : flags // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            population: freezed == population
                ? _value.population
                : population // ignore: cast_nullable_to_non_nullable
                      as int?,
            capital: freezed == capital
                ? _value.capital
                : capital // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
            region: freezed == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String?,
            subregion: freezed == subregion
                ? _value.subregion
                : subregion // ignore: cast_nullable_to_non_nullable
                      as String?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as double?,
            timezones: freezed == timezones
                ? _value.timezones
                : timezones // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CountryDetailModelImplCopyWith<$Res>
    implements $CountryDetailModelCopyWith<$Res> {
  factory _$$CountryDetailModelImplCopyWith(
    _$CountryDetailModelImpl value,
    $Res Function(_$CountryDetailModelImpl) then,
  ) = __$$CountryDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? cca2,
    Map<String, dynamic>? name,
    Map<String, dynamic>? flags,
    int? population,
    List<dynamic>? capital,
    String? region,
    String? subregion,
    double? area,
    List<String>? timezones,
  });
}

/// @nodoc
class __$$CountryDetailModelImplCopyWithImpl<$Res>
    extends _$CountryDetailModelCopyWithImpl<$Res, _$CountryDetailModelImpl>
    implements _$$CountryDetailModelImplCopyWith<$Res> {
  __$$CountryDetailModelImplCopyWithImpl(
    _$CountryDetailModelImpl _value,
    $Res Function(_$CountryDetailModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cca2 = freezed,
    Object? name = freezed,
    Object? flags = freezed,
    Object? population = freezed,
    Object? capital = freezed,
    Object? region = freezed,
    Object? subregion = freezed,
    Object? area = freezed,
    Object? timezones = freezed,
  }) {
    return _then(
      _$CountryDetailModelImpl(
        cca2: freezed == cca2
            ? _value.cca2
            : cca2 // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value._name
            : name // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        flags: freezed == flags
            ? _value._flags
            : flags // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        population: freezed == population
            ? _value.population
            : population // ignore: cast_nullable_to_non_nullable
                  as int?,
        capital: freezed == capital
            ? _value._capital
            : capital // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String?,
        subregion: freezed == subregion
            ? _value.subregion
            : subregion // ignore: cast_nullable_to_non_nullable
                  as String?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as double?,
        timezones: freezed == timezones
            ? _value._timezones
            : timezones // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryDetailModelImpl extends _CountryDetailModel {
  const _$CountryDetailModelImpl({
    required this.cca2,
    required final Map<String, dynamic>? name,
    required final Map<String, dynamic>? flags,
    required this.population,
    required final List<dynamic>? capital,
    required this.region,
    required this.subregion,
    required this.area,
    required final List<String>? timezones,
  }) : _name = name,
       _flags = flags,
       _capital = capital,
       _timezones = timezones,
       super._();

  factory _$CountryDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryDetailModelImplFromJson(json);

  @override
  final String? cca2;
  final Map<String, dynamic>? _name;
  @override
  Map<String, dynamic>? get name {
    final value = _name;
    if (value == null) return null;
    if (_name is EqualUnmodifiableMapView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _flags;
  @override
  Map<String, dynamic>? get flags {
    final value = _flags;
    if (value == null) return null;
    if (_flags is EqualUnmodifiableMapView) return _flags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? population;
  final List<dynamic>? _capital;
  @override
  List<dynamic>? get capital {
    final value = _capital;
    if (value == null) return null;
    if (_capital is EqualUnmodifiableListView) return _capital;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? region;
  @override
  final String? subregion;
  @override
  final double? area;
  final List<String>? _timezones;
  @override
  List<String>? get timezones {
    final value = _timezones;
    if (value == null) return null;
    if (_timezones is EqualUnmodifiableListView) return _timezones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CountryDetailModel(cca2: $cca2, name: $name, flags: $flags, population: $population, capital: $capital, region: $region, subregion: $subregion, area: $area, timezones: $timezones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryDetailModelImpl &&
            (identical(other.cca2, cca2) || other.cca2 == cca2) &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            const DeepCollectionEquality().equals(other._flags, _flags) &&
            (identical(other.population, population) ||
                other.population == population) &&
            const DeepCollectionEquality().equals(other._capital, _capital) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.subregion, subregion) ||
                other.subregion == subregion) &&
            (identical(other.area, area) || other.area == area) &&
            const DeepCollectionEquality().equals(
              other._timezones,
              _timezones,
            ));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cca2,
    const DeepCollectionEquality().hash(_name),
    const DeepCollectionEquality().hash(_flags),
    population,
    const DeepCollectionEquality().hash(_capital),
    region,
    subregion,
    area,
    const DeepCollectionEquality().hash(_timezones),
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryDetailModelImplCopyWith<_$CountryDetailModelImpl> get copyWith =>
      __$$CountryDetailModelImplCopyWithImpl<_$CountryDetailModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryDetailModelImplToJson(this);
  }
}

abstract class _CountryDetailModel extends CountryDetailModel {
  const factory _CountryDetailModel({
    required final String? cca2,
    required final Map<String, dynamic>? name,
    required final Map<String, dynamic>? flags,
    required final int? population,
    required final List<dynamic>? capital,
    required final String? region,
    required final String? subregion,
    required final double? area,
    required final List<String>? timezones,
  }) = _$CountryDetailModelImpl;
  const _CountryDetailModel._() : super._();

  factory _CountryDetailModel.fromJson(Map<String, dynamic> json) =
      _$CountryDetailModelImpl.fromJson;

  @override
  String? get cca2;
  @override
  Map<String, dynamic>? get name;
  @override
  Map<String, dynamic>? get flags;
  @override
  int? get population;
  @override
  List<dynamic>? get capital;
  @override
  String? get region;
  @override
  String? get subregion;
  @override
  double? get area;
  @override
  List<String>? get timezones;
  @override
  @JsonKey(ignore: true)
  _$$CountryDetailModelImplCopyWith<_$CountryDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

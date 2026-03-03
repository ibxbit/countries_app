part of 'country_summary_model.dart';

// FreezedGenerator

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CountrySummaryModel _$CountrySummaryModelFromJson(Map<String, dynamic> json) {
  return _CountrySummaryModel.fromJson(json);
}

/// @nodoc
mixin _$CountrySummaryModel {
  @HiveField(0)
  Map<String, dynamic>? get name => throw _privateConstructorUsedError;
  @HiveField(1)
  Map<String, dynamic>? get flags => throw _privateConstructorUsedError;
  @HiveField(2)
  int? get population => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get cca2 => throw _privateConstructorUsedError;
  @HiveField(4)
  List<dynamic>? get capital => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CountrySummaryModelCopyWith<CountrySummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountrySummaryModelCopyWith<$Res> {
  factory $CountrySummaryModelCopyWith(
    CountrySummaryModel value,
    $Res Function(CountrySummaryModel) then,
  ) = _$CountrySummaryModelCopyWithImpl<$Res, CountrySummaryModel>;
  @useResult
  $Res call({
    @HiveField(0) Map<String, dynamic>? name,
    @HiveField(1) Map<String, dynamic>? flags,
    @HiveField(2) int? population,
    @HiveField(3) String? cca2,
    @HiveField(4) List<dynamic>? capital,
  });
}

/// @nodoc
class _$CountrySummaryModelCopyWithImpl<$Res, $Val extends CountrySummaryModel>
    implements $CountrySummaryModelCopyWith<$Res> {
  _$CountrySummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? flags = freezed,
    Object? population = freezed,
    Object? cca2 = freezed,
    Object? capital = freezed,
  }) {
    return _then(
      _value.copyWith(
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
            cca2: freezed == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                      as String?,
            capital: freezed == capital
                ? _value.capital
                : capital // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CountrySummaryModelImplCopyWith<$Res>
    implements $CountrySummaryModelCopyWith<$Res> {
  factory _$$CountrySummaryModelImplCopyWith(
    _$CountrySummaryModelImpl value,
    $Res Function(_$CountrySummaryModelImpl) then,
  ) = __$$CountrySummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) Map<String, dynamic>? name,
    @HiveField(1) Map<String, dynamic>? flags,
    @HiveField(2) int? population,
    @HiveField(3) String? cca2,
    @HiveField(4) List<dynamic>? capital,
  });
}

/// @nodoc
class __$$CountrySummaryModelImplCopyWithImpl<$Res>
    extends _$CountrySummaryModelCopyWithImpl<$Res, _$CountrySummaryModelImpl>
    implements _$$CountrySummaryModelImplCopyWith<$Res> {
  __$$CountrySummaryModelImplCopyWithImpl(
    _$CountrySummaryModelImpl _value,
    $Res Function(_$CountrySummaryModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? flags = freezed,
    Object? population = freezed,
    Object? cca2 = freezed,
    Object? capital = freezed,
  }) {
    return _then(
      _$CountrySummaryModelImpl(
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
        cca2: freezed == cca2
            ? _value.cca2
            : cca2 // ignore: cast_nullable_to_non_nullable
                  as String?,
        capital: freezed == capital
            ? _value._capital
            : capital // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CountrySummaryModelImpl extends _CountrySummaryModel {
  const _$CountrySummaryModelImpl({
    @HiveField(0) required final Map<String, dynamic>? name,
    @HiveField(1) required final Map<String, dynamic>? flags,
    @HiveField(2) required this.population,
    @HiveField(3) required this.cca2,
    @HiveField(4) required final List<dynamic>? capital,
  }) : _name = name,
       _flags = flags,
       _capital = capital,
       super._();

  factory _$CountrySummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountrySummaryModelImplFromJson(json);

  final Map<String, dynamic>? _name;
  @override
  @HiveField(0)
  Map<String, dynamic>? get name {
    final value = _name;
    if (value == null) return null;
    if (_name is EqualUnmodifiableMapView) return _name;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _flags;
  @override
  @HiveField(1)
  Map<String, dynamic>? get flags {
    final value = _flags;
    if (value == null) return null;
    if (_flags is EqualUnmodifiableMapView) return _flags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @HiveField(2)
  final int? population;
  @override
  @HiveField(3)
  final String? cca2;
  final List<dynamic>? _capital;
  @override
  @HiveField(4)
  List<dynamic>? get capital {
    final value = _capital;
    if (value == null) return null;
    if (_capital is EqualUnmodifiableListView) return _capital;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CountrySummaryModel(name: $name, flags: $flags, population: $population, cca2: $cca2, capital: $capital)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountrySummaryModelImpl &&
            const DeepCollectionEquality().equals(other._name, _name) &&
            const DeepCollectionEquality().equals(other._flags, _flags) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.cca2, cca2) || other.cca2 == cca2) &&
            const DeepCollectionEquality().equals(other._capital, _capital));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_name),
    const DeepCollectionEquality().hash(_flags),
    population,
    cca2,
    const DeepCollectionEquality().hash(_capital),
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CountrySummaryModelImplCopyWith<_$CountrySummaryModelImpl> get copyWith =>
      __$$CountrySummaryModelImplCopyWithImpl<_$CountrySummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CountrySummaryModelImplToJson(this);
  }
}

abstract class _CountrySummaryModel extends CountrySummaryModel {
  const factory _CountrySummaryModel({
    @HiveField(0) required final Map<String, dynamic>? name,
    @HiveField(1) required final Map<String, dynamic>? flags,
    @HiveField(2) required final int? population,
    @HiveField(3) required final String? cca2,
    @HiveField(4) required final List<dynamic>? capital,
  }) = _$CountrySummaryModelImpl;
  const _CountrySummaryModel._() : super._();

  factory _CountrySummaryModel.fromJson(Map<String, dynamic> json) =
      _$CountrySummaryModelImpl.fromJson;

  @override
  @HiveField(0)
  Map<String, dynamic>? get name;
  @override
  @HiveField(1)
  Map<String, dynamic>? get flags;
  @override
  @HiveField(2)
  int? get population;
  @override
  @HiveField(3)
  String? get cca2;
  @override
  @HiveField(4)
  List<dynamic>? get capital;
  @override
  @JsonKey(ignore: true)
  _$$CountrySummaryModelImplCopyWith<_$CountrySummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

import 'package:equatable/equatable.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

enum SortBy { name, population }

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CountrySummary> countries;
  final List<CountrySummary> filteredCountries;
  final String searchQuery;
  final SortBy sortBy;

  const HomeLoaded({
    required this.countries,
    this.filteredCountries = const [],
    this.searchQuery = '',
    this.sortBy = SortBy.name,
  });

  @override
  List<Object?> get props => [
    countries,
    filteredCountries,
    searchQuery,
    sortBy,
  ];

  HomeLoaded copyWith({
    List<CountrySummary>? countries,
    List<CountrySummary>? filteredCountries,
    String? searchQuery,
    SortBy? sortBy,
  }) {
    return HomeLoaded(
      countries: countries ?? this.countries,
      filteredCountries: filteredCountries ?? this.filteredCountries,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

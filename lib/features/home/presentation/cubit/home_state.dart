import 'package:equatable/equatable.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CountrySummary> countries;
  final List<CountrySummary> filteredCountries;
  final String searchQuery;

  const HomeLoaded({
    required this.countries,
    this.filteredCountries = const [],
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [countries, filteredCountries, searchQuery];

  HomeLoaded copyWith({
    List<CountrySummary>? countries,
    List<CountrySummary>? filteredCountries,
    String? searchQuery,
  }) {
    return HomeLoaded(
      countries: countries ?? this.countries,
      filteredCountries: filteredCountries ?? this.filteredCountries,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:countries_app/features/home/domain/usecases/get_all_countries.dart';
import 'package:countries_app/features/home/domain/usecases/search_countries.dart';
import 'package:countries_app/core/usecases/usecase.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllCountries getAllCountries;
  final SearchCountries searchCountries;

  HomeCubit({required this.getAllCountries, required this.searchCountries})
    : super(HomeInitial());

  Timer? _debounce;
  int _searchRequestId = 0;

  Future<void> loadCountries() async {
    emit(HomeLoading());
    final result = await getAllCountries(NoParams());
    result.fold((failure) => emit(HomeError(failure.message)), (countries) {
      final sorted = _sortCountries(countries, SortBy.name);
      emit(HomeLoaded(countries: sorted, filteredCountries: sorted));
    });
  }

  void onSortChanged(SortBy sortBy) {
    if (state is! HomeLoaded) return;
    final currentState = state as HomeLoaded;

    final sortedFiltered = _sortCountries(
      currentState.filteredCountries,
      sortBy,
    );
    final sortedAll = _sortCountries(currentState.countries, sortBy);

    emit(
      currentState.copyWith(
        countries: sortedAll,
        filteredCountries: sortedFiltered,
        sortBy: sortBy,
      ),
    );
  }

  List<CountrySummary> _sortCountries(
    List<CountrySummary> list,
    SortBy sortBy,
  ) {
    final sorted = List<CountrySummary>.from(list);
    if (sortBy == SortBy.name) {
      sorted.sort(
        (CountrySummary a, CountrySummary b) =>
            a.commonName.compareTo(b.commonName),
      );
    } else if (sortBy == SortBy.population) {
      // Descending population
      sorted.sort(
        (CountrySummary a, CountrySummary b) =>
            b.population.compareTo(a.population),
      );
    }
    return sorted;
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    if (state is! HomeLoaded) return;
    final currentState = state as HomeLoaded;
    final normalizedQuery = query.trim();

    if (normalizedQuery.isEmpty) {
      emit(
        currentState.copyWith(
          filteredCountries: currentState.countries,
          searchQuery: '',
        ),
      );
      return;
    }

    // Local search first for immediate UI feedback.
    final localFiltered = currentState.countries.where((c) {
      return c.commonName.toLowerCase().contains(normalizedQuery.toLowerCase());
    }).toList();

    emit(
      currentState.copyWith(
        filteredCountries: _sortCountries(localFiltered, currentState.sortBy),
        searchQuery: normalizedQuery,
      ),
    );

    final requestId = ++_searchRequestId;
    final result = await searchCountries(normalizedQuery);

    if (requestId != _searchRequestId || state is! HomeLoaded) {
      return;
    }

    final latestState = state as HomeLoaded;
    result.fold(
      (failure) {
        emit(
          latestState.copyWith(
            filteredCountries: _sortCountries(
              localFiltered,
              latestState.sortBy,
            ),
            searchQuery: normalizedQuery,
          ),
        );
      },
      (countries) {
        emit(
          latestState.copyWith(
            filteredCountries: _sortCountries(countries, latestState.sortBy),
            searchQuery: normalizedQuery,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:countries_app/features/home/domain/usecases/get_all_countries.dart';
import 'package:countries_app/features/home/domain/usecases/search_countries.dart';
import 'package:countries_app/core/usecases/usecase.dart';
import 'package:countries_app/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllCountries getAllCountries;
  final SearchCountries searchCountries;

  HomeCubit({required this.getAllCountries, required this.searchCountries})
    : super(HomeInitial());

  Timer? _debounce;

  Future<void> loadCountries() async {
    emit(HomeLoading());
    final result = await getAllCountries(NoParams());
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (countries) =>
          emit(HomeLoaded(countries: countries, filteredCountries: countries)),
    );
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

    if (query.isEmpty) {
      emit(
        currentState.copyWith(
          filteredCountries: currentState.countries,
          searchQuery: '',
        ),
      );
      return;
    }

    // Offline search first for better UX
    final localFiltered = currentState.countries.where((c) {
      return c.commonName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(
      currentState.copyWith(
        filteredCountries: localFiltered,
        searchQuery: query,
      ),
    );

    // Optional: Call API if local search results are sparse or if you want fresh data
    // For this task, local filtering of the "All" list is usually enough for "real-time" search.
    // However, the user story says "search for a country by name", and Step 1 API has a search endpoint.
    // I'll stick to local filtering if we already have the full list, but I could call the API too.
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

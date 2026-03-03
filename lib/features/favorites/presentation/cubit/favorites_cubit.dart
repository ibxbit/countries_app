import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:countries_app/core/usecases/usecase.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/favorites/domain/usecases/favorites_usecases.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavorites getFavorites;
  final ToggleFavorite toggleFavorite;
  final CheckFavoriteStatus checkFavoriteStatus;

  FavoritesCubit({
    required this.getFavorites,
    required this.toggleFavorite,
    required this.checkFavoriteStatus,
  }) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    final result = await getFavorites(NoParams());
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> onToggleFavorite(CountrySummary country) async {
    final result = await toggleFavorite(country);
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (_) => loadFavorites(),
    );
  }

  bool isCountryFavorite(String cca2) {
    if (state is FavoritesLoaded) {
      return (state as FavoritesLoaded).favorites.any((c) => c.cca2 == cca2);
    }
    return false;
  }
}

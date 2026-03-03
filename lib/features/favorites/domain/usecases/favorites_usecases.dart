import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/core/usecases/usecase.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/favorites/domain/repositories/favorites_repository.dart';

class GetFavorites implements UseCase<List<CountrySummary>, NoParams> {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  @override
  Future<Either<Failure, List<CountrySummary>>> call(NoParams params) async {
    return await repository.getFavorites();
  }
}

class ToggleFavorite implements UseCase<void, CountrySummary> {
  final FavoritesRepository repository;

  ToggleFavorite(this.repository);

  @override
  Future<Either<Failure, void>> call(CountrySummary params) async {
    final isFavResult = await repository.isFavorite(params.cca2);
    return isFavResult.fold((failure) => Left(failure), (isFav) async {
      if (isFav) {
        return await repository.removeFromFavorites(params.cca2);
      } else {
        return await repository.addToFavorites(params);
      }
    });
  }
}

class CheckFavoriteStatus implements UseCase<bool, String> {
  final FavoritesRepository repository;

  CheckFavoriteStatus(this.repository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.isFavorite(params);
  }
}

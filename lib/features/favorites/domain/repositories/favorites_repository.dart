import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<CountrySummary>>> getFavorites();
  Future<Either<Failure, void>> addToFavorites(CountrySummary country);
  Future<Either<Failure, void>> removeFromFavorites(String cca2);
  Future<Either<Failure, bool>> isFavorite(String cca2);
}

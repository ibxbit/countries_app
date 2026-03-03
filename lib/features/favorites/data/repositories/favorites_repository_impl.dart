import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/features/home/data/models/country_summary_model.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:countries_app/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CountrySummary>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(CountrySummary country) async {
    try {
      final model = CountrySummaryModel(
        name: {'common': country.commonName},
        flags: {'png': country.flagPng, 'svg': country.flagSvg},
        population: country.population,
        cca2: country.cca2,
        capital: [country.capital],
      );
      await localDataSource.addToFavorites(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String cca2) async {
    try {
      await localDataSource.removeFromFavorites(cca2);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String cca2) async {
    try {
      final result = await localDataSource.isFavorite(cca2);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

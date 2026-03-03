import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CountrySummary>>> getAllCountries() async {
    try {
      final remoteCountries = await remoteDataSource.getAllCountries();
      return Right(remoteCountries.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CountrySummary>>> searchCountries(
    String name,
  ) async {
    try {
      final remoteCountries = await remoteDataSource.searchCountries(name);
      return Right(remoteCountries.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

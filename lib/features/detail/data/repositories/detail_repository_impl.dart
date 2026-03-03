import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../datasources/detail_remote_data_source.dart';
import '../../domain/entities/country_detail.dart';
import '../../domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDataSource remoteDataSource;

  DetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CountryDetail>> getCountryDetail(String code) async {
    try {
      final remoteCountry = await remoteDataSource.getCountryDetail(code);
      return Right(remoteCountry.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

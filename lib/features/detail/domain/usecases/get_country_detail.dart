import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country_detail.dart';
import '../repositories/detail_repository.dart';

class GetCountryDetail implements UseCase<CountryDetail, String> {
  final DetailRepository repository;

  GetCountryDetail(this.repository);

  @override
  Future<Either<Failure, CountryDetail>> call(String params) async {
    return await repository.getCountryDetail(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/core/usecases/usecase.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/home/domain/repositories/home_repository.dart';

class GetAllCountries implements UseCase<List<CountrySummary>, NoParams> {
  final HomeRepository repository;

  GetAllCountries(this.repository);

  @override
  Future<Either<Failure, List<CountrySummary>>> call(NoParams params) async {
    return await repository.getAllCountries();
  }
}

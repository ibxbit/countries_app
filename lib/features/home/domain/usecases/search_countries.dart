import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/core/usecases/usecase.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';
import 'package:countries_app/features/home/domain/repositories/home_repository.dart';

class SearchCountries implements UseCase<List<CountrySummary>, String> {
  final HomeRepository repository;

  SearchCountries(this.repository);

  @override
  Future<Either<Failure, List<CountrySummary>>> call(String params) async {
    return await repository.searchCountries(params);
  }
}

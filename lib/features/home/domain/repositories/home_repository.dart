import 'package:dartz/dartz.dart';
import 'package:countries_app/core/error/failures.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CountrySummary>>> getAllCountries();
  Future<Either<Failure, List<CountrySummary>>> searchCountries(String name);
}

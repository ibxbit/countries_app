import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/country_detail.dart';

abstract class DetailRepository {
  Future<Either<Failure, CountryDetail>> getCountryDetail(String code);
}

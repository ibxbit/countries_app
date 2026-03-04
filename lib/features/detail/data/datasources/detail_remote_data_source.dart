import '../../../../core/utils/dio_client.dart';
import '../models/country_detail_model.dart';

abstract class DetailRemoteDataSource {
  Future<CountryDetailModel> getCountryDetail(String code);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final DioClient client;

  DetailRemoteDataSourceImpl({required this.client});

  bool _isSuccessful(int? statusCode) {
    if (statusCode == null) return false;
    return (statusCode >= 200 && statusCode < 300) || statusCode == 304;
  }

  @override
  Future<CountryDetailModel> getCountryDetail(String code) async {
    final response = await client.get(
      '/alpha/$code?fields=cca2,name,flags,population,capital,region,subregion,area,timezones',
    );

    if (_isSuccessful(response.statusCode)) {
      if (response.data is List && (response.data as List).isNotEmpty) {
        return CountryDetailModel.fromJson(response.data[0]);
      } else if (response.data is Map<String, dynamic>) {
        return CountryDetailModel.fromJson(response.data);
      }
      throw Exception('Unexpected response format');
    } else {
      throw Exception('Failed to load country detail');
    }
  }
}

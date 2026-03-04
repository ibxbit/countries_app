import 'package:countries_app/core/utils/dio_client.dart';
import 'package:countries_app/features/home/data/models/country_summary_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CountrySummaryModel>> getAllCountries();
  Future<List<CountrySummaryModel>> searchCountries(String name);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient client;

  HomeRemoteDataSourceImpl({required this.client});

  Map<String, dynamic> _normalizeCountryJson(dynamic json) {
    final map = Map<String, dynamic>.from(json as Map);
    map.putIfAbsent('capital', () => null);
    return map;
  }

  bool _isSuccessful(int? statusCode) {
    if (statusCode == null) return false;
    return (statusCode >= 200 && statusCode < 300) || statusCode == 304;
  }

  @override
  Future<List<CountrySummaryModel>> getAllCountries() async {
    final response = await client.get('/all?fields=name,flags,population,cca2');

    if (_isSuccessful(response.statusCode)) {
      final List<dynamic> jsonList = response.data;
      return jsonList
          .map(
            (json) => CountrySummaryModel.fromJson(_normalizeCountryJson(json)),
          )
          .toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  @override
  Future<List<CountrySummaryModel>> searchCountries(String name) async {
    final response = await client.get(
      '/name/$name?fields=name,flags,population,cca2',
    );

    if (_isSuccessful(response.statusCode)) {
      final List<dynamic> jsonList = response.data;
      return jsonList
          .map(
            (json) => CountrySummaryModel.fromJson(_normalizeCountryJson(json)),
          )
          .toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to search countries');
    }
  }
}

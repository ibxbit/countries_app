import 'package:hive_flutter/hive_flutter.dart';
import 'package:countries_app/features/home/data/models/country_summary_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<CountrySummaryModel>> getFavorites();
  Future<void> addToFavorites(CountrySummaryModel country);
  Future<void> removeFromFavorites(String cca2);
  Future<bool> isFavorite(String cca2);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<CountrySummaryModel> favoritesBox;

  FavoritesLocalDataSourceImpl({required this.favoritesBox});

  @override
  Future<List<CountrySummaryModel>> getFavorites() async {
    return favoritesBox.values.toList();
  }

  @override
  Future<void> addToFavorites(CountrySummaryModel country) async {
    await favoritesBox.put(country.cca2, country);
  }

  @override
  Future<void> removeFromFavorites(String cca2) async {
    await favoritesBox.delete(cca2);
  }

  @override
  Future<bool> isFavorite(String cca2) async {
    return favoritesBox.containsKey(cca2);
  }
}

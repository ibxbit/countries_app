import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:countries_app/core/utils/dio_client.dart';
import 'package:countries_app/features/detail/data/datasources/detail_remote_data_source.dart';
import 'package:countries_app/features/detail/data/repositories/detail_repository_impl.dart';
import 'package:countries_app/features/detail/domain/repositories/detail_repository.dart';
import 'package:countries_app/features/detail/domain/usecases/get_country_detail.dart';
import 'package:countries_app/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:countries_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:countries_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:countries_app/features/favorites/domain/usecases/favorites_usecases.dart';
import 'package:countries_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:countries_app/features/home/data/models/country_summary_model.dart';
import 'package:countries_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:countries_app/features/home/domain/repositories/home_repository.dart';
import 'package:countries_app/features/home/domain/usecases/get_all_countries.dart';
import 'package:countries_app/features/home/domain/usecases/search_countries.dart';
import 'package:countries_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:countries_app/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Home
  // Bloc
  sl.registerFactory(
    () => HomeCubit(getAllCountries: sl(), searchCountries: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllCountries(sl()));
  sl.registerLazySingleton(() => SearchCountries(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Detail
  // Bloc
  sl.registerFactory(() => DetailCubit(getCountryDetail: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCountryDetail(sl()));

  // Repository
  sl.registerLazySingleton<DetailRepository>(
    () => DetailRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<DetailRemoteDataSource>(
    () => DetailRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Favorites
  // Bloc
  sl.registerFactory(
    () => FavoritesCubit(
      getFavorites: sl(),
      toggleFavorite: sl(),
      checkFavoriteStatus: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => CheckFavoriteStatus(sl()));

  // Repository
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      localDataSource: sl(),
      detailRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(favoritesBox: sl()),
  );

  //! External
  final dio = Dio();
  sl.registerLazySingleton<Dio>(() => dio);

  //! Core
  final dioClient = DioClient(dio);
  await dioClient.init();
  sl.registerLazySingleton<DioClient>(() => dioClient);

  await Hive.initFlutter();
  Hive.registerAdapter(CountrySummaryModelAdapter());

  final favoritesBox = await Hive.openBox<CountrySummaryModel>('favorites');
  sl.registerLazySingleton(() => favoritesBox);
}

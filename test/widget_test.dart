import 'package:flutter_test/flutter_test.dart';
import 'package:countries_app/main.dart';
import 'package:countries_app/di/injection_container.dart' as di;
import 'package:countries_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:countries_app/features/home/presentation/cubit/home_state.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Simple stub classes to avoid full initialization in tests
class StubHomeCubit extends Cubit<HomeState> implements HomeCubit {
  StubHomeCubit() : super(HomeInitial());
  @override
  Future<void> loadCountries() async {}
  @override
  void onSearchChanged(String query) {}
  @override
  void onSortChanged(SortBy sortBy) {}

  @override
  get getAllCountries => throw UnimplementedError();
  @override
  get searchCountries => throw UnimplementedError();
}

class StubFavoritesCubit extends Cubit<FavoritesState>
    implements FavoritesCubit {
  StubFavoritesCubit() : super(FavoritesInitial());
  @override
  Future<void> loadFavorites() async {}
  @override
  Future<void> onToggleFavorite(dynamic country) async {}
  @override
  bool isCountryFavorite(String cca2) => false;

  @override
  get getFavorites => throw UnimplementedError();
  @override
  get toggleFavorite => throw UnimplementedError();
  @override
  get checkFavoriteStatus => throw UnimplementedError();
}

void main() {
  setUp(() {
    // Register stubs to avoid Sl not found errors
    if (!di.sl.isRegistered<HomeCubit>()) {
      di.sl.registerFactory<HomeCubit>(() => StubHomeCubit());
    }
    if (!di.sl.isRegistered<FavoritesCubit>()) {
      di.sl.registerFactory<FavoritesCubit>(() => StubFavoritesCubit());
    }
  });

  testWidgets('App should load', (WidgetTester tester) async {
    // Using a simpler MaterialApp for testing to avoid full app initialization if needed,
    // but here we try to pump the actual MyApp to verify it doesn't crash.
    await tester.pumpWidget(const MyApp());

    // Verify that the app widget is present
    expect(find.byType(MyApp), findsOneWidget);
  });
}

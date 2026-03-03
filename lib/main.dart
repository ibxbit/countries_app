import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'di/injection_container.dart' as di;
import 'core/presentation/pages/main_screen.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/favorites/presentation/cubit/favorites_cubit.dart';
import 'features/detail/presentation/pages/detail_screen.dart';
import 'features/detail/presentation/cubit/detail_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<HomeCubit>()..loadCountries()),
        BlocProvider(create: (_) => di.sl<FavoritesCubit>()..loadFavorites()),
      ],
      child: MaterialApp(
        title: 'Countries App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.jetBrainsMonoTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
        home: const MainScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == '/detail') {
            final cca2 = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => di.sl<DetailCubit>()..loadCountryDetail(cca2),
                child: DetailScreen(cca2: cca2),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}

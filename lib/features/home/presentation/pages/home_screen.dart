import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:countries_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:countries_app/features/home/presentation/cubit/home_state.dart';
import 'package:countries_app/features/home/presentation/widgets/country_list_tile.dart';
import 'package:countries_app/features/home/presentation/widgets/country_list_shimmer.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:countries_app/di/injection_container.dart' as di;
import 'package:countries_app/features/detail/presentation/pages/detail_screen.dart';
import 'package:countries_app/features/detail/presentation/cubit/detail_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Determine the "top part" color. Usually the AppBar surface tint or background.
    final appBarColor = theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'World Countries',
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: _isScrolled ? 2 : 0,
        backgroundColor: appBarColor,
        surfaceTintColor: appBarColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (query) => context.read<HomeCubit>().onSearchChanged(query),
              decoration: InputDecoration(
                hintText: 'Search for a country',
                hintStyle: GoogleFonts.jetBrainsMono(fontSize: 14),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: _isScrolled 
                      ? BorderSide(color: theme.colorScheme.primary, width: 1.5)
                      : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: _isScrolled 
                      ? BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.5), width: 1.5)
                      : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              style: GoogleFonts.jetBrainsMono(fontSize: 15),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoading) {
            return const CountryListShimmer();
          } else if (homeState is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(homeState.message, style: GoogleFonts.jetBrainsMono()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().loadCountries(),
                    child: Text('Retry', style: GoogleFonts.jetBrainsMono()),
                  ),
                ],
              ),
            );
          } else if (homeState is HomeLoaded) {
            final countries = homeState.filteredCountries;
            if (countries.isEmpty) {
              return Center(
                child: Text(
                  'No countries found.',
                  style: GoogleFonts.jetBrainsMono(),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().loadCountries(),
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      final isFav = context.read<FavoritesCubit>().isCountryFavorite(country.cca2);
                      return CountryListTile(
                        country: country,
                        isFavorite: isFav,
                        onToggleFavorite: () {
                          context.read<FavoritesCubit>().onToggleFavorite(country);
                        },
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) {
                              return BlocProvider(
                                create: (_) => di.sl<DetailCubit>()..loadCountryDetail(country.cca2),
                                child: DraggableScrollableSheet(
                                  initialChildSize: 0.9,
                                  minChildSize: 0.5,
                                  maxChildSize: 0.95,
                                  builder: (_, scrollController) {
                                    return DetailScreen(
                                      cca2: country.cca2,
                                      scrollController: scrollController,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

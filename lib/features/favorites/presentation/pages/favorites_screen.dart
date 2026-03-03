import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:countries_app/features/home/presentation/widgets/country_list_tile.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:countries_app/di/injection_container.dart' as di;
import 'package:countries_app/features/detail/presentation/pages/detail_screen.dart';
import 'package:countries_app/features/detail/presentation/cubit/detail_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Countries'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesError) {
            return Center(child: Text(state.message));
          } else if (state is FavoritesLoaded) {
            final favorites = state.favorites;
            if (favorites.isEmpty) {
              return const Center(child: Text('No countries have been favorited.'));
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final country = favorites[index];
                return CountryListTile(
                  country: country,
                  isFavorite: true,
                  subtitle: 'Capital: ${country.capital}',
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
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:countries_app/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:countries_app/features/detail/presentation/cubit/detail_state.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:countries_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  final String cca2;
  final ScrollController? scrollController;

  const DetailScreen({super.key, required this.cca2, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          String title = 'Country Detail';
          if (state is DetailLoaded) {
            title = state.country.commonName;
          }

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: colorScheme.surface,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: colorScheme.onSurface,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                title,
                style: GoogleFonts.jetBrainsMono(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              actions: [
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, favState) {
                    if (state is! DetailLoaded) return const SizedBox.shrink();
                    final isFav = context
                        .read<FavoritesCubit>()
                        .isCountryFavorite(state.country.cca2);
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => context
                          .read<FavoritesCubit>()
                          .onToggleFavorite(state.country.toSummary()),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 4),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),

                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: _buildBody(context, state),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DetailState state) {
    if (state is DetailLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is DetailError) {
      return _buildError(context, state.message);
    } else if (state is DetailLoaded) {
      final country = state.country;
      return BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFlagSection(context, country.flagPng, country.commonName),
                const SizedBox(height: 24),

                Text(
                  'Key Statistics',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                _buildInfoGrid(context, country),
                const SizedBox(height: 32),

                _buildTimezoneSection(context, country),
                const SizedBox(height: 32),

                _buildSpecsSection(context, country),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildFlagSection(BuildContext context, String flagUrl, String name) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Hero(
          tag: 'flag_$name',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: flagUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoGrid(BuildContext context, dynamic country) {
    final formatter = NumberFormat.decimalPattern();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatRow(context, 'Capital', country.capital),
        _buildStatRow(context, 'Area', '${formatter.format(country.area)} sq km'),
        _buildStatRow(context, 'Population', formatter.format(country.population)),
        _buildStatRow(context, 'Region', country.region),
        _buildStatRow(context, 'Sub Region', country.subregion),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.jetBrainsMono(
              color: colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimezoneSection(BuildContext context, dynamic country) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Timezone',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: country.timezones.map<Widget>((tz) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.7),
                ),
              ),
              child: Text(
                tz,
                style: GoogleFonts.jetBrainsMono(
                  color: colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpecsSection(BuildContext context, dynamic country) {
    return const SizedBox.shrink();
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.jetBrainsMono(),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<DetailCubit>().loadCountryDetail(cca2),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

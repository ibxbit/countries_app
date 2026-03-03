import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/country_summary.dart';

class CountryListTile extends StatelessWidget {
  final CountrySummary country;
  final bool isFavorite;
  final String? subtitle;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  const CountryListTile({
    super.key,
    required this.country,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final populationFormat = NumberFormat.compact();
    final populationStr = populationFormat.format(country.population);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Hero(
              tag: 'flag_${country.commonName}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: country.flagPng,
                  width: 60,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[300], width: 60, height: 40),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.commonName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle ?? 'Population: $populationStr',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: onToggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

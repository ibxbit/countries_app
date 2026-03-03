import 'package:equatable/equatable.dart';
import 'package:countries_app/features/home/domain/entities/country_summary.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<CountrySummary> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

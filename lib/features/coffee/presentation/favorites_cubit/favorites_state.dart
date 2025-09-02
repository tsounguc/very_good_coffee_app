part of 'favorites_cubit.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

final class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

final class FavoriteRemoved extends FavoritesState {
  const FavoriteRemoved();
}

final class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.favorites);

  final List<Coffee> favorites;
  @override
  List<Object> get props => [favorites];
}

final class FavoritesError extends FavoritesState {
  const FavoritesError(this.message);

  final String message;

  @override
  List<Object> get props => [this.message];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/get_favorites.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/remove_favorite.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required RemoveFavorite removeFavorite,
    required GetFavorites getFavorites,
  }) : _removeFavorite = removeFavorite,
       _getFavorites = getFavorites,
       super(const FavoritesInitial());

  final RemoveFavorite _removeFavorite;
  final GetFavorites _getFavorites;

  Future<void> remove(Coffee coffee) async {
    emit(const FavoritesLoading());
    final result = await _removeFavorite(coffee);

    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (success) => emit(const FavoriteRemoved()),
    );
  }

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());
    final result = await _getFavorites();

    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }
}

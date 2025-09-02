import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/get_favorites.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/remove_favorite.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/favorites_cubit/favorites_cubit.dart';

class MockRemoveFavorite extends Mock implements RemoveFavorite {}

class MockGetFavorites extends Mock implements GetFavorites {}

void main() {
  late RemoveFavorite removeFavorite;
  late GetFavorites getFavorites;

  late FavoritesCubit cubit;

  const testCoffee = Coffee.empty();

  const testFavorites = [
    Coffee(imageUrl: 'u1'),
    Coffee(imageUrl: 'u2'),
  ];

  setUp(() {
    removeFavorite = MockRemoveFavorite();
    getFavorites = MockGetFavorites();

    cubit = FavoritesCubit(
      removeFavorite: removeFavorite,
      getFavorites: getFavorites,
    );

    registerFallbackValue(testCoffee);
  });

  test(
    'given FavoritesCubit '
    'when cubit is instantiate '
    'then initial state should be [FavoritesInitial] ',
    () async {
      // Arrange
      // Act
      // Assert
      expect(cubit.state, const FavoritesInitial());
    },
  );

  group('remove - ', () {
    blocTest<FavoritesCubit, FavoritesState>(
      'given FavoritesCubit '
      'when [FavoritesCubit.remove] is called '
      'and complete successfully '
      'then emit [FavoritesLoading, FavoriteRemoved]',
      build: () {
        when(
          () => removeFavorite(any()),
        ).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.remove(testCoffee),
      expect: () => [
        const FavoritesLoading(),
        const FavoriteRemoved(),
      ],
      verify: (_) {
        verify(
          () => removeFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(removeFavorite);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'given FavoritesCubit, '
      'when [FavoritesCubit.remove] is called unsuccessfully '
      'then emit [FavoritesLoading, FavoritesError]',
      build: () {
        when(
          () => removeFavorite(any()),
        ).thenAnswer(
          (_) async => Left(
            RemoveFavoriteFailure(
              message: 'Something went wrong',
              statusCode: '500',
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.remove(testCoffee),
      expect: () => [
        const FavoritesLoading(),
        const FavoritesError('Something went wrong'),
      ],
      verify: (_) {
        verify(
          () => removeFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(removeFavorite);
      },
    );
  });

  group('loadFavorites - ', () {
    blocTest<FavoritesCubit, FavoritesState>(
      'given FavoritesCubit '
      'when [FavoritesCubit.loadFavorites] is called '
      'and complete successfully '
      'then emit [FavoritesLoading, FavoritesLoaded]',
      build: () {
        when(
          () => getFavorites(),
        ).thenAnswer((_) async => const Right(testFavorites));
        return cubit;
      },
      act: (cubit) => cubit.loadFavorites(),
      expect: () => [
        const FavoritesLoading(),
        const FavoritesLoaded(testFavorites),
      ],
      verify: (_) {
        verify(
          () => getFavorites(),
        ).called(1);
        verifyNoMoreInteractions(getFavorites);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'given FavoritesCubit, '
      'when [FavoritesCubit.loadFavorites] is called unsuccessfully '
      'then emit [FavoritesLoading, FavoritesError]',
      build: () {
        when(
          () => getFavorites(),
        ).thenAnswer(
          (_) async => Left(
            GetFavoritesFailure(
              message: 'Something went wrong',
              statusCode: '500',
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadFavorites(),
      expect: () => [
        const FavoritesLoading(),
        const FavoritesError('Something went wrong'),
      ],
      verify: (_) {
        verify(
          () => getFavorites(),
        ).called(1);
        verifyNoMoreInteractions(getFavorites);
      },
    );
  });
}

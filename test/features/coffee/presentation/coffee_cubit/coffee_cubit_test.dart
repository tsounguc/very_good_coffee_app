import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/get_random_coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/save_favorite.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/coffee_cubit/coffee_cubit.dart';

class MockSaveFavorite extends Mock implements SaveFavorite {}

class MockGetRandomCoffee extends Mock implements GetRandomCoffee {}

void main() {
  late SaveFavorite saveFavorite;
  late GetRandomCoffee getRandomCoffee;

  late CoffeeCubit cubit;

  const testCoffee = Coffee.empty();

  setUp(() {
    saveFavorite = MockSaveFavorite();
    getRandomCoffee = MockGetRandomCoffee();

    cubit = CoffeeCubit(
      getRandomCoffee: getRandomCoffee,
      saveFavorite: saveFavorite,
    );
    registerFallbackValue(testCoffee);
  });

  test(
    'given CoffeeCubit '
    'when cubit is instantiate '
    'then initial state should be [CoffeeInitial] ',
    () async {
      // Arrange
      // Act
      // Assert
      expect(cubit.state, const CoffeeInitial());
    },
  );

  group('save - ', () {
    blocTest<CoffeeCubit, CoffeeState>(
      'given CoffeeCubit '
      'when [CoffeeCubit.save] is called '
      'and complete successfully '
      'then emit [CoffeeLoading, CoffeeSaved]',
      build: () {
        when(
          () => saveFavorite(any()),
        ).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.save(testCoffee),
      expect: () => [
        const CoffeeLoading(),
        const CoffeeSaved(testCoffee),
      ],
      verify: (_) {
        verify(
          () => saveFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(saveFavorite);
      },
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'given CoffeeCubit, '
      'when [CoffeeCubit.save] is called unsuccessfully '
      'then emit [CoffeeLoading, CoffeeError]',
      build: () {
        when(
          () => saveFavorite(any()),
        ).thenAnswer(
          (_) async => Left(
            SaveFavoriteFailure(
              message: 'Something went wrong',
              statusCode: '500',
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.save(testCoffee),
      expect: () => [
        const CoffeeLoading(),
        const CoffeeError('Something went wrong'),
      ],
      verify: (_) {
        verify(
          () => saveFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(saveFavorite);
      },
    );
  });

  group('getRandomCoffee - ', () {
    blocTest<CoffeeCubit, CoffeeState>(
      'given CoffeeCubit '
      'when [CoffeeCubit.getRandomCoffee] is called '
      'and complete successfully '
      'then emit [CoffeeLoading, RandomCoffeeLoaded]',
      build: () {
        when(
          () => getRandomCoffee(),
        ).thenAnswer((_) async => const Right(testCoffee));
        return cubit;
      },
      act: (cubit) => cubit.getRandomCoffee(),
      expect: () => [
        const CoffeeLoading(),
        const RandomCoffeeLoaded(testCoffee),
      ],
      verify: (_) {
        verify(
          () => getRandomCoffee(),
        ).called(1);
        verifyNoMoreInteractions(getRandomCoffee);
      },
    );

    blocTest<CoffeeCubit, CoffeeState>(
      'given CoffeeCubit, '
      'when [CoffeeCubit.getRandomCoffee] is called unsuccessfully '
      'then emit [CoffeeLoading, CoffeeError]',
      build: () {
        when(
          () => getRandomCoffee(),
        ).thenAnswer(
          (_) async => Left(
            GetRandomCoffeeFailure(
              message: 'Something went wrong',
              statusCode: '500',
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.getRandomCoffee(),
      expect: () => [
        const CoffeeLoading(),
        const CoffeeError('Something went wrong'),
      ],
      verify: (_) {
        verify(
          () => getRandomCoffee(),
        ).called(1);
        verifyNoMoreInteractions(getRandomCoffee);
      },
    );
  });
}

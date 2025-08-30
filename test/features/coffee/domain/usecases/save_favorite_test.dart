import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';

import 'coffee_repository.mock.dart';

void main() {
  late CoffeeRepository repository;
  late SaveFavorite useCase;

  const testCoffee = Coffee.empty();
  setUp(() {
    repository = MockCoffeeRepository();
    useCase = SaveFavorite(repository);
    registerFallbackValue(testCoffee);
  });

  test(
    'given SaveFavorite '
    'when instantiated '
    'then call [CoffeeRepository.saveFavorite] '
    'and return [void] ',
    () async {
      // Arrange
      when(
        () => repository.saveFavorite(any()),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(testCoffee);

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(
        () => repository.saveFavorite(testCoffee),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given SaveFavorite '
    'when instantiated '
    'and call [CoffeeRepository.saveFavorite] is unsuccessful '
    'then return [SaveFavoriteFailure] ',
    () async {
      // Arrange
      final testFailure = SaveFavoriteFailure(
        message: 'message',
        statusCode: '500',
      );
      when(
        () => repository.saveFavorite(any()),
      ).thenAnswer((_) async => Left(testFailure));

      // Act
      final result = await useCase(testCoffee);

      // Assert
      expect(result, Left<Failure, void>(testFailure));
      verify(
        () => repository.saveFavorite(testCoffee),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}

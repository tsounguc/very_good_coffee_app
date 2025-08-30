import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';

import 'coffee_repository.mock.dart';

void main() {
  late CoffeeRepository repository;
  late RemoveFavorite useCase;

  const testCoffee = Coffee.empty();
  setUp(() {
    repository = MockCoffeeRepository();
    useCase = RemoveFavorite(repository);
    registerFallbackValue(testCoffee);
  });

  test(
    'given RemoveFavorite '
    'when instantiated '
    'then call [CoffeeRepository.removeFavorite] '
    'and return [void] ',
    () async {
      // Arrange
      when(
        () => repository.removeFavorite(any()),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(testCoffee);

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(
        () => repository.removeFavorite(testCoffee),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given RemoveFavorite '
    'when instantiated '
    'and call [CoffeeRepository.removeFavorite] is unsuccessful '
    'then return [RemoveFavoriteFailure] ',
    () async {
      // Arrange
      final testFailure = RemoveFavoriteFailure(
        message: 'message',
        statusCode: '500',
      );
      when(
        () => repository.removeFavorite(any()),
      ).thenAnswer((_) async => Left(testFailure));

      // Act
      final result = await useCase(testCoffee);

      // Assert
      expect(result, Left<Failure, void>(testFailure));
      verify(
        () => repository.removeFavorite(testCoffee),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}

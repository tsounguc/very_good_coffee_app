import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/get_random_coffee.dart';

import 'coffee_repository.mock.dart';

void main() {
  late CoffeeRepository repository;
  late GetRandomCoffee useCase;

  const testCoffee = Coffee.empty();

  setUp(() {
    repository = MockCoffeeRepository();
    useCase = GetRandomCoffee(repository);
  });

  test(
    'given GetRandomCoffee, '
    'when instantiated '
    'then call [CoffeeRepository.getRandomCoffee] '
    'and return [Coffee] ',
    () async {
      // Arrange
      when(
        () => repository.getRandomCoffee(),
      ).thenAnswer((_) async => const Right(testCoffee));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right<Failure, Coffee>(testCoffee));
      verify(
        () => repository.getRandomCoffee(),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given GetRandomCoffee, '
    'when instantiated '
    'and call [CoffeeRepository.getRandomCoffee] is unsuccessful '
    'and return [GetRandomCoffeeFailure] ',
    () async {
      // Arrange
      final testFailure = GetRandomCoffeeFailure(
        message: 'message',
        statusCode: '500',
      );
      when(
        () => repository.getRandomCoffee(),
      ).thenAnswer((_) async => Left(testFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, Left<Failure, Coffee>(testFailure));
      verify(
        () => repository.getRandomCoffee(),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}

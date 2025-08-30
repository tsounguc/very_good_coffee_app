import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';

import 'coffee_repository.mock.dart';

void main() {
  late CoffeeRepository repository;
  late GetFavorites useCase;

  final testFavorites = [const Coffee.empty()];
  setUp(() {
    repository = MockCoffeeRepository();
    useCase = GetFavorites(repository);
  });

  test(
    'given GetFavorites '
    'when instantiated '
    'then call [CoffeeRepository.getFavorite] '
    'and return [List<Coffee>] ',
    () async {
      // Arrange
      when(
        () => repository.getFavorites(),
      ).thenAnswer((_) async => Right(testFavorites));

      // Act
      final result = await useCase();

      // Assert
      expect(result, Right<Failure, List<Coffee>>(testFavorites));
      verify(() => repository.getFavorites()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given GetFavorites '
    'when instantiated '
    'and call [CoffeeRepository.getFavorite] is unsuccessful '
    'then return [GetFavoritesFailure] ',
    () async {
      // Arrange
      final testFailure = GetFavoritesFailure(
        message: 'message',
        statusCode: '500',
      );
      when(
        () => repository.getFavorites(),
      ).thenAnswer((_) async => Left(testFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, Left<Failure, List<Coffee>>(testFailure));
      verify(
        () => repository.getFavorites(),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}

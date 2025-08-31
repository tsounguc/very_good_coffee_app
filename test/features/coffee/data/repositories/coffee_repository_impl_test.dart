import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/exceptions.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_local_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_remote_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';
import 'package:very_good_coffee_app/features/coffee/data/repositories/coffee_repository_impl.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';

class MockCoffeeRemoteDataSource extends Mock implements CoffeeRemoteDataSource {}

class MockCoffeeLocalDataSource extends Mock implements CoffeeLocalDataSource {}

void main() {
  late CoffeeRemoteDataSource remoteDataSource;
  late CoffeeLocalDataSource localDataSource;

  late CoffeeRepositoryImpl repositoryImpl;

  const testCoffeeModel = CoffeeModel.empty();
  const testFavorites = [CoffeeModel.empty()];
  const testCoffee = Coffee.empty();

  setUp(() {
    remoteDataSource = MockCoffeeRemoteDataSource();
    localDataSource = MockCoffeeLocalDataSource();

    repositoryImpl = CoffeeRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    registerFallbackValue(testCoffee);
  });

  test(
    'given CoffeeRepositoryImpl, '
    'when instantiate '
    'then instance should subclass of [CoffeeRepository]',
    () async {
      // Arrange
      // Act
      // Assert
      expect(repositoryImpl, isA<CoffeeRepository>());
    },
  );

  group('getRandomCoffee - ', () {
    test(
      'given CoffeeRepositoryImpl, '
      'when [ClientRemoteDataSource.fetchRandomCoffee] is called '
      'then return [Coffee]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.fetchRandomCoffee(),
        ).thenAnswer((_) async => testCoffeeModel);

        // Act
        final result = await repositoryImpl.getRandomCoffee();

        // Assert
        expect(result, const Right<Failure, Coffee>(testCoffeeModel));
        verify(
          () => remoteDataSource.fetchRandomCoffee(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given CoffeeRepositoryImpl, '
      'and call [CoffeeRemoteDataSource.fetchRandomCoffee] unsuccessful '
      'then return [GetRandomCoffeeFailure] ',
      () async {
        // Arrange
        final testException = GetRandomCoffeeException(
          message: 'message',
          statusCode: 'statusCode',
        );
        when(
          () => remoteDataSource.fetchRandomCoffee(),
        ).thenThrow(testException);

        // Act
        final result = await repositoryImpl.getRandomCoffee();

        // Assert
        expect(
          result,
          Left<Failure, Coffee>(
            GetRandomCoffeeFailure.fromException(testException),
          ),
        );
        verify(
          () => remoteDataSource.fetchRandomCoffee(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('saveFavorite - ', () {
    test(
      'given CoffeeRepositoryImpl, '
      'when [CoffeeLocalDataSource.saveFavorite] is called '
      'then return [void] ',
      () async {
        // Arrange
        when(
          () => localDataSource.saveFavorite(any()),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repositoryImpl.saveFavorite(testCoffee);

        // Assert
        expect(result, const Right<Failure, void>(null));
        verify(
          () => localDataSource.saveFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'given CoffeeRepositoryImpl, '
      'and call [CoffeeLocalDataSource.saveFavorite] unsuccessful '
      'then return [SaveFavoriteException]',
      () async {
        // Arrange
        const testException = SaveFavoriteException(
          message: 'message',
          statusCode: 'statusCode',
        );
        when(
          () => localDataSource.saveFavorite(any()),
        ).thenThrow(testException);

        // Act
        final result = await repositoryImpl.saveFavorite(testCoffee);

        // Assert
        expect(
          result,
          Left<Failure, void>(
            SaveFavoriteFailure.fromException(testException),
          ),
        );
        verify(
          () => localDataSource.saveFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('removeFavorite - ', () {
    test(
      'given CoffeeRepositoryImpl, '
      'when [CoffeeLocalDataSource.removeFavorite] is called '
      'then return [void]',
      () async {
        // Arrange
        when(
          () => localDataSource.removeFavorite(any()),
        ).thenAnswer((_) => Future.value());

        // Act
        final result = await repositoryImpl.removeFavorite(testCoffee);

        // Assert
        expect(result, const Right<Failure, void>(null));
        verify(
          () => localDataSource.removeFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'given CoffeeRepositoryImpl, '
      'and call [CoffeeLocalDataSource.removeFavorite] unsuccessful '
      'then return [RemoveFavoriteFailure]',
      () async {
        // Arrange
        const testException = RemoveFavoriteException(
          message: 'message',
          statusCode: 'statusCode',
        );
        when(
          () => localDataSource.removeFavorite(any()),
        ).thenThrow(testException);

        // Act
        final result = await repositoryImpl.removeFavorite(testCoffee);

        // Assert
        expect(
          result,
          Left<Failure, void>(
            RemoveFavoriteFailure.fromException(testException),
          ),
        );
        verify(
          () => localDataSource.removeFavorite(testCoffee),
        ).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('getFavorites - ', () {
    test(
      'given CoffeeRepositoryImpl, '
      'when [CoffeeLocalDataSource.getFavorites] is called '
      'then return [List<Coffee>]',
      () async {
        // Arrange
        when(
          () => localDataSource.getFavorites(),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await repositoryImpl.getFavorites();

        // Assert
        expect(
          result,
          const Right<Failure, List<Coffee>>(testFavorites),
        );
        verify(
          () => localDataSource.getFavorites(),
        ).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'given CoffeeRepositoryImpl, '
      'and call [CoffeeLocalDataSource.getFavorites] unsuccessful '
      'then return [GetFavoritesFailure]',
      () async {
        // Arrange
        const testException = GetFavoritesException(
          message: 'message',
          statusCode: 'statusCode',
        );
        when(
          () => localDataSource.getFavorites(),
        ).thenThrow(testException);

        // Act
        final result = await repositoryImpl.getFavorites();

        // Assert
        expect(
          result,
          Left<Failure, List<Coffee>>(
            GetFavoritesFailure.fromException(testException),
          ),
        );
        verify(
          () => localDataSource.getFavorites(),
        ).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}

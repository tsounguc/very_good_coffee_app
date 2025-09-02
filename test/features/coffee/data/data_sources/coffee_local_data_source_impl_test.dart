import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/exceptions.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_local_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBoxString extends Mock implements Box<String> {}

void main() {
  late HiveInterface hive;
  late Box<String> box;
  late CoffeeLocalDataSourceImpl localDataSourceImpl;

  const testCoffee = Coffee.empty();
  final testFavorites = [
    const CoffeeModel(imageUrl: 'u1'),
    const CoffeeModel(imageUrl: 'u2'),
  ];

  setUpAll(() {
    hive = MockHive();
    box = MockBoxString();
    localDataSourceImpl = CoffeeLocalDataSourceImpl(hive);

    // Always stub openBox to return the mock box
    when(() => hive.openBox<String>(any())).thenAnswer((_) async => box);

    // Common stubs
    when(() => box.isOpen).thenReturn(true);
  });

  group('saveFavorite - ', () {
    test(
      'given CoffeeLocalDataSourceImpl, '
      'when [Box.put] is called '
      'then return [void]',
      () async {
        // Arrange
        when(() => box.values).thenReturn(const <String>[]);
        when(
          () => box.put(any<String>(), any()),
        ).thenAnswer((_) async => Future.value());

        // Act
        await localDataSourceImpl.saveFavorite(testCoffee);

        // Assert
        verify(
          () => box.put(
            testCoffee.imageUrl,
            testCoffee.imageUrl,
          ),
        ).called(1);
      },
    );

    test(
      'given CoffeeLocalDataSourceImpl, '
      'when [Box.put] is called '
      'and coffee is already saved '
      'then do nothing',
      () async {
        // Arrange
        when(() => box.values).thenReturn(<String>[testCoffee.imageUrl]);
        when(
          () => box.put(any<String>(), any()),
        ).thenAnswer((_) async => Future.value());

        // Act
        await localDataSourceImpl.saveFavorite(testCoffee);

        // Assert
        verifyNever(
          () => box.put(
            any<String>(),
            any(),
          ),
        );
      },
    );

    test(
      'given CoffeeLocalDataSourceImpl, '
      'when [Box.put] is called '
      'then throw [SaveFavoriteException]',
      () async {
        // Arrange
        const testException = SaveFavoriteException(
          message: 'message',
          statusCode: 'statusCode',
        );

        when(() => box.values).thenReturn(const <String>[]);
        when(
          () => box.put(any<String>(), any()),
        ).thenThrow(testException);

        // Act
        final methodCall = localDataSourceImpl.saveFavorite;

        // Assert
        expect(
          () => methodCall(testCoffee),
          throwsA(isA<SaveFavoriteException>()),
        );
      },
    );
  });

  group('removeFavorite - ', () {
    test(
      'given CoffeeLocalDataSourceImpl, '
      'when [Box.delete] is called '
      'then return [void]',
      () async {
        // Arrange
        when(
          () => box.delete(any<String>()),
        ).thenAnswer((_) async => Future.value());

        // Act
        await localDataSourceImpl.removeFavorite(testCoffee);

        // Assert
        verify(
          () => box.delete(testCoffee.imageUrl),
        ).called(1);
      },
    );

    test(
      'given CoffeeLocalDataSourceImpl, '
      'when [Box.delete] is called '
      'then throw [RemoveFavoriteException]',
      () async {
        // Arrange
        const testException = RemoveFavoriteException(
          message: 'message',
          statusCode: 'statusCode',
        );

        when(() => box.values).thenReturn(const <String>[]);
        when(
          () => box.delete(any<String>()),
        ).thenThrow(testException);

        // Act
        final methodCall = localDataSourceImpl.removeFavorite;

        // Assert
        expect(
          () => methodCall(testCoffee),
          throwsA(isA<RemoveFavoriteException>()),
        );
      },
    );
  });

  group('getFavorites - ', () {
    test(
      'given CoffeeLocalDataSourceImpl, '
      'when [box.values] is called '
      'then return [List<Coffee>]',
      () async {
        // Arrange
        when(() => box.values).thenReturn(
          testFavorites.map((fav) => fav.imageUrl),
        );

        // Act
        final result = await localDataSourceImpl.getFavorites();

        // Arrange
        expect(
          result.map((coffee) => coffee.imageUrl),
          testFavorites.map((fav) => fav.imageUrl),
        );
      },
    );

    test(
      'given CoffeeLocalDataSourceImpl, '
      'when [Box.values] is called '
      'then throw [GetFavoritesException]',
      () async {
        // Arrange
        const testException = GetFavoritesException(
          message: 'message',
          statusCode: 'statusCode',
        );

        when(() => box.values).thenThrow(testException);

        // Act
        final methodCall = localDataSourceImpl.getFavorites;

        // Assert
        expect(
          () => methodCall(),
          throwsA(isA<GetFavoritesException>()),
        );
      },
    );
  });
}

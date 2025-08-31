import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/core/errors/exceptions.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_remote_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client client;
  late CoffeeRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    client = MockClient();
    remoteDataSourceImpl = CoffeeRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('fetchRandomCoffee', () {
    final testJson = fixture('coffee.json');
    const url = 'https://coffee.alexflipnote.dev/random.json';
    test(
      'given CoffeeRemoteDataSourceImpl, '
      'when [Client.get] is called '
      'and status is 200 '
      'then return [CoffeeModel]',
      () async {
        // Arrange
        when(
          () => client.get(any()),
        ).thenAnswer((_) async => Response(testJson, 200));

        // Act
        final result = remoteDataSourceImpl.fetchRandomCoffee();

        // Assert
        expect(result, isA<CoffeeModel>());
        verify(
          () => client.get(Uri.parse(url)),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'given CoffeeRemoteDataSourceImpl, ',
      () async {
        // Arrange
        when(
          () => client.get(any()),
        ).thenAnswer((_) async => Response('Image Not Found', 404));

        // Act
        final methodCall = remoteDataSourceImpl.fetchRandomCoffee;

        // Assert
        expect(
          () async => methodCall(),
          throwsA(
            GetRandomCoffeeException(
              message: 'Image Not Found',
              statusCode: '404',
            ),
          ),
        );
        verify(
          () => client.get(
            Uri.parse(url),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testJson = fixture('coffee.json');
  final testCoffeeModel = CoffeeModel.fromJson(testJson);
  final testMap = testCoffeeModel.toMap();

  test('given [CoffeeModel], '
      'when instantiated '
      'then instance should be subclass of [Coffee]', () {
    // Arrange
    // Act
    // Assert
    expect(testCoffeeModel, isA<Coffee>());
  });

  group('fromMap - ', () {
    test('given [CoffeeModel], '
        'when fromMap is called, '
        'then return [CoffeeModel] with correct data ', () {
      // Arrange
      // Act
      final result = CoffeeModel.fromMap(testMap);
      // Assert
      expect(result, isA<CoffeeModel>());
      expect(result, equals(testCoffeeModel));
    });
  });

  group('toMap - ', () {
    test('given [CoffeeModel], '
        'when toMap is called, '
        'then return [Map] with correct data ', () {
      // Arrange
      // Act
      final result = testCoffeeModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });

  group('copyWith - ', () {
    const testImageUrl = 'test url';
    test('given [CoffeeModel], '
        'when copyWith is called, '
        'then return [CoffeeModel] with updated data ', () {
      // Arrange
      // Act
      final result = testCoffeeModel.copyWith(imageUrl: testImageUrl);
      // Assert
      expect(result.imageUrl, equals(testImageUrl));
    });
  });
}

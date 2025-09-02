import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBoxString extends Mock implements Box<String> {}

void main() {
  late HiveInterface hive;
  late Box<String> box;
  late CoffeeLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    hive = MockHive();
    box = MockBoxString();
  });

  test('description', () async {
    // Arrange

    // Act
    // Assert
  });
}

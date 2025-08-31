import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';

abstract class CoffeeLocalDataSource {
  Future<List<CoffeeModel>> getFavorites();
  Future<void> saveFavorite(Coffee coffee);
  Future<void> removeFavorite(Coffee coffee);
}

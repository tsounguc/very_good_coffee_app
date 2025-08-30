import 'package:very_good_coffee_app/core/utils/type_defs.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';

abstract class CoffeeRepository {
  ResultFuture<Coffee> getRandomCoffee();
  ResultVoid saveFavorite(Coffee coffee);
  ResultFuture<List<Coffee>> getFavorites();
  ResultVoid removeFavorite(Coffee coffee);
}

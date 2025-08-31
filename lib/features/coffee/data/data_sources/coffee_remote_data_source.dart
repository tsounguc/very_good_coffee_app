import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';

abstract class CoffeeRemoteDataSource {
  Future<CoffeeModel> fetchRandomCoffee();
}

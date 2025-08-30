import 'package:very_good_coffee_app/core/usecases/usecase.dart';
import 'package:very_good_coffee_app/core/utils/type_defs.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';

class RemoveFavorite extends UseCaseWithParams<void, Coffee> {
  RemoveFavorite(this.repository);

  final CoffeeRepository repository;

  @override
  ResultFuture<void> call(Coffee params) => repository.removeFavorite(params);
}

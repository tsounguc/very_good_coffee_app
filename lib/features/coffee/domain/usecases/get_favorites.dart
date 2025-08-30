import 'package:very_good_coffee_app/core/usecases/usecase.dart';
import 'package:very_good_coffee_app/core/utils/type_defs.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';

class GetFavorites extends UseCase<List<Coffee>> {
  GetFavorites(this.repository);

  final CoffeeRepository repository;

  @override
  ResultFuture<List<Coffee>> call() => repository.getFavorites();
}

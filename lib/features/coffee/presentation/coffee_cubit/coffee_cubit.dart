import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/get_random_coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/save_favorite.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit({
    required SaveFavorite saveFavorite,
    required GetRandomCoffee getRandomCoffee,
  }) : _saveFavorite = saveFavorite,
       _getRandomCoffee = getRandomCoffee,
       super(const CoffeeInitial());

  final GetRandomCoffee _getRandomCoffee;
  final SaveFavorite _saveFavorite;

  Future<void> save(Coffee coffee) async {
    final result = await _saveFavorite(coffee);

    result.fold(
      (failure) => emit(CoffeeError(failure.message)),
      (success) {
        emit(CoffeeSaved(coffee));
        emit(RandomCoffeeLoaded(coffee));
      },
    );
  }

  Future<void> getRandomCoffee() async {
    emit(const CoffeeLoading());
    final result = await _getRandomCoffee();

    result.fold(
      (failure) => emit(CoffeeError(failure.message)),
      (coffee) => emit(RandomCoffeeLoaded(coffee)),
    );
  }
}

part of 'coffee_cubit.dart';

sealed class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object> get props => [];
}

final class CoffeeInitial extends CoffeeState {
  const CoffeeInitial();
}

final class CoffeeLoading extends CoffeeState {
  const CoffeeLoading();
}

final class CoffeeError extends CoffeeState {
  const CoffeeError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class CoffeeSaved extends CoffeeState {
  const CoffeeSaved();
}

final class RandomCoffeeLoaded extends CoffeeState {
  const RandomCoffeeLoaded(this.coffee);

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}

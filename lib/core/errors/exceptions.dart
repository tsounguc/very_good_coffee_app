import 'package:equatable/equatable.dart';

/// **Base class for all coffee-related exception.**
abstract class CoffeeException extends Equatable implements Exception {
  const CoffeeException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Exception thrown when getting a random coffee.**
class GetRandomCoffeeException extends CoffeeException {
  GetRandomCoffeeException({
    required super.message,
    required super.statusCode,
  });
}

/// **Exception thrown when getting list of favorite coffee.**
class GetFavoritesException extends CoffeeException {
  const GetFavoritesException({
    required super.message,
    required super.statusCode,
  });
}

/// **Exception thrown when saving coffee to favorites.**
class SaveFavoriteException extends CoffeeException {
  const SaveFavoriteException({
    required super.message,
    required super.statusCode,
  });
}

/// **Exception thrown when removing coffee from favorites.**
class RemoveFavoriteException extends CoffeeException {
  const RemoveFavoriteException({
    required super.message,
    required super.statusCode,
  });
}

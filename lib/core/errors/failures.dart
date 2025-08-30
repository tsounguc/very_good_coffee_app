import 'package:equatable/equatable.dart';
import 'package:very_good_coffee_app/core/errors/exceptions.dart';

/// Base class for handling failures across the app.
///
/// [Failure] ensures all errors are **typed**,
/// rather than using raw exceptions.
/// This helps with **better error handling** and **functional programming**.
///
/// - `message`: Human-readable error description.
/// - `statusCode`: Can be an `int` (e.g., HTTP 404) or
/// `String` (e.g., Firebase error codes).
abstract class Failure extends Equatable {
  /// Creates a [Failure] instance.
  ///
  /// - **message**: Describes the error.
  /// - **statusCode**: Can be an integer (e.g., HTTP error codes) or
  /// a string (e.g., Firebase error codes).
  Failure({required this.message, required this.statusCode})
    : assert(
        statusCode is String || statusCode is int,
        'StatusCode cannot be a ${statusCode.runtimeType}',
      );

  /// The error message (human-readable).
  final String message;

  /// Error code, which may be an `int` (for HTTP errors)
  /// or `String` (Firebase errors).
  final dynamic statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// **Base class for all Coffee failures**
///
/// This allows us to have specific failure types.
abstract class CoffeeFailure extends Failure {
  CoffeeFailure({
    required super.message,
    required super.statusCode,
  });
}

/// **Failure that occurs when getting a random coffee.
class GetRandomCoffeeFailure extends CoffeeFailure {
  GetRandomCoffeeFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [GetRandomCoffeeException] into [GetRandomCoffeeFailure]
  GetRandomCoffeeFailure.fromException(GetRandomCoffeeException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

/// **Failure that occurs when getting list of favorite coffee.
class GetFavoritesFailure extends CoffeeFailure {
  GetFavoritesFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [GetFavoritesException] into [GetFavoritesFailure]
  GetFavoritesFailure.fromException(GetFavoritesException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

/// **Failure that occurs when saving a coffee to favorites.
class SaveFavoriteFailure extends CoffeeFailure {
  SaveFavoriteFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [SaveFavoriteException] into [SaveFavoriteFailure]
  SaveFavoriteFailure.fromException(SaveFavoriteException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

/// **Failure that occurs when removing a coffee from favorites.
class RemoveFavoriteFailure extends CoffeeFailure {
  RemoveFavoriteFailure({
    required super.message,
    required super.statusCode,
  });

  /// Converts a [RemoveFavoriteException] into [RemoveFavoriteFailure]
  RemoveFavoriteFailure.fromException(RemoveFavoriteException exception)
    : this(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

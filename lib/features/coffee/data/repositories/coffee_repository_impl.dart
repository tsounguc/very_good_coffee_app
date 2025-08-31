import 'package:dartz/dartz.dart';
import 'package:very_good_coffee_app/core/errors/exceptions.dart';
import 'package:very_good_coffee_app/core/errors/failures.dart';
import 'package:very_good_coffee_app/core/utils/type_defs.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_local_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_remote_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';

class CoffeeRepositoryImpl implements CoffeeRepository {
  CoffeeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final CoffeeLocalDataSource localDataSource;
  final CoffeeRemoteDataSource remoteDataSource;

  @override
  ResultFuture<List<Coffee>> getFavorites() async {
    try {
      final result = await localDataSource.getFavorites();
      return Right(result);
    } on GetFavoritesException catch (e) {
      return Left(GetFavoritesFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Coffee> getRandomCoffee() async {
    try {
      final result = await remoteDataSource.fetchRandomCoffee();
      return Right(result);
    } on GetRandomCoffeeException catch (e) {
      return Left(GetRandomCoffeeFailure.fromException(e));
    }
  }

  @override
  ResultVoid removeFavorite(Coffee coffee) async {
    try {
      final result = await localDataSource.removeFavorite(coffee);
      return Right(result);
    } on RemoveFavoriteException catch (e) {
      return Left(RemoveFavoriteFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveFavorite(Coffee coffee) async {
    try {
      final result = await localDataSource.saveFavorite(coffee);
      return Right(result);
    } on SaveFavoriteException catch (e) {
      return Left(SaveFavoriteFailure.fromException(e));
    }
  }
}

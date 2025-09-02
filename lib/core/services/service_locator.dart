import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_local_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/data/data_sources/coffee_remote_data_source.dart';
import 'package:very_good_coffee_app/features/coffee/data/repositories/coffee_repository_impl.dart';
import 'package:very_good_coffee_app/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/get_favorites.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/get_random_coffee.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/remove_favorite.dart';
import 'package:very_good_coffee_app/features/coffee/domain/usecases/save_favorite.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/coffee_cubit/coffee_cubit.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/favorites_cubit/favorites_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
  await _initCoffee();
  await _initFavorites();
}

Future<void> _initCoffee() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => CoffeeCubit(
        saveFavorite: serviceLocator(),
        getRandomCoffee: serviceLocator(),
      ),
    )
    // Usecases
    ..registerLazySingleton(() => SaveFavorite(serviceLocator()))
    ..registerLazySingleton(() => GetRandomCoffee(serviceLocator()))
    ..registerLazySingleton(() => RemoveFavorite(serviceLocator()))
    ..registerLazySingleton(() => GetFavorites(serviceLocator()))
    // Repositories
    ..registerLazySingleton<CoffeeRepository>(
      () => CoffeeRepositoryImpl(
        localDataSource: serviceLocator(),
        remoteDataSource: serviceLocator(),
      ),
    )
    // Data sources
    ..registerLazySingleton<CoffeeLocalDataSource>(
      () => CoffeeLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton<CoffeeRemoteDataSource>(
      () => CoffeeRemoteDataSourceImpl(serviceLocator()),
    )
    // External dependencies
    ..registerLazySingleton(Client.new)
    ..registerSingleton<HiveInterface>(Hive);
}

Future<void> _initFavorites() async {
  serviceLocator
  // App Logic
  .registerFactory(
    () => FavoritesCubit(
      removeFavorite: serviceLocator(),
      getFavorites: serviceLocator(),
    ),
  )
  // Usecases
  // Repositories
  // Data sources
  // External dependencies
  ;
}

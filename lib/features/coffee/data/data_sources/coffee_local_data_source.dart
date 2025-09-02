import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:very_good_coffee_app/core/errors/exceptions.dart';
import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';

abstract class CoffeeLocalDataSource {
  Future<void> init();
  Future<List<CoffeeModel>> getFavorites();
  Future<void> saveFavorite(Coffee coffee);
  Future<void> removeFavorite(Coffee coffee);
}

class CoffeeLocalDataSourceImpl implements CoffeeLocalDataSource {
  CoffeeLocalDataSourceImpl(this.hive);

  final HiveInterface hive;
  static const boxName = 'favorites_box';
  Box<String>? _box;

  @override
  Future<void> init() async {
    _box = await hive.openBox(boxName);
  }

  Box<String> get box {
    final b = _box;
    if (b == null) {
      throw StateError('FavoritesLocalDataSource used before init()');
    }
    return b;
  }

  @override
  Future<void> saveFavorite(Coffee coffee) async {
    try {
      if (!box.values.contains(coffee.imageUrl)) {
        await box.put(
          coffee.imageUrl,
          coffee.imageUrl,
        );
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw const SaveFavoriteException(
        message: 'Unexpected error saving coffee image',
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> removeFavorite(Coffee coffee) async {
    try {
      await box.delete(coffee.imageUrl);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw const RemoveFavoriteException(
        message: 'Unexpected error removing coffee image',
        statusCode: '500',
      );
    }
  }

  @override
  Future<List<CoffeeModel>> getFavorites() async {
    try {
      return box.values
          .map(
            (value) => CoffeeModel(imageUrl: value),
          )
          .toList(growable: false);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw const GetFavoritesException(
        message: 'Unexpected error getting coffee images',
        statusCode: '500',
      );
    }
  }
}

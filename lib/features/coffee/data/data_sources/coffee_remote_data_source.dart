import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:very_good_coffee_app/core/errors/exceptions.dart';
import 'package:very_good_coffee_app/core/utils/type_defs.dart';
import 'package:very_good_coffee_app/features/coffee/data/models/coffee_model.dart';

abstract class CoffeeRemoteDataSource {
  Future<CoffeeModel> fetchRandomCoffee();
}

class CoffeeRemoteDataSourceImpl implements CoffeeRemoteDataSource {
  CoffeeRemoteDataSourceImpl(this.client);

  final Client client;
  @override
  Future<CoffeeModel> fetchRandomCoffee() async {
    try {
      const url = 'https://coffee.alexflipnote.dev/random.json';
      final response = await client.get(Uri.parse(url));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw GetRandomCoffeeException(
          message: 'Failed to load coffee image',
          statusCode: response.statusCode.toString(),
        );
      }
      final data = jsonDecode(response.body);

      final coffee = CoffeeModel.fromMap(
        data as DataMap,
      );
      return coffee;
    } on GetRandomCoffeeException catch (e, s) {
      debugPrintStack(stackTrace: s);
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw GetRandomCoffeeException(
        message: 'Unexpected error fetching coffee image',
        statusCode: '500',
      );
    }
  }
}

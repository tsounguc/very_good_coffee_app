import 'dart:convert';

import 'package:very_good_coffee_app/core/utils/type_defs.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';

class CoffeeModel extends Coffee {
  const CoffeeModel({
    required super.imageUrl,
  });

  /// Represents an empty [CoffeeModel] instance.
  ///
  /// Used for default values or initializing empty states.
  const CoffeeModel.empty() : this(imageUrl: '_empty.file');

  /// Creates a [CoffeeModel] from a JSON string.
  factory CoffeeModel.fromJson(String source) => CoffeeModel.fromMap(jsonDecode(source) as DataMap);

  /// Creates a [CoffeeModel] from a key-value map.
  CoffeeModel.fromMap(DataMap dataMap)
    : this(
        imageUrl: dataMap['file'] as String,
      );

  /// Converts a [CoffeeModel] instance to a JSON string.
  String toJson() => jsonEncode(toMap());

  /// Converts a [CoffeeModel] instance to a key-value map.
  DataMap toMap() => {
    'file': imageUrl,
  };

  /// Creates a copy of the current [CoffeeModel] with optional updates.
  CoffeeModel copyWith({String? imageUrl}) {
    return CoffeeModel(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

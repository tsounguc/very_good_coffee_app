import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';

class CoffeeImageScreen extends StatelessWidget {
  const CoffeeImageScreen({
    required this.coffee,
    required this.heroTag,
    super.key,
  });

  static const String id = '/coffeeImageScreen';

  final Coffee coffee;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: coffee.imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}

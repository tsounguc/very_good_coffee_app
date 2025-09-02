import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/coffee_cubit/coffee_cubit.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/views/coffee_image_screen.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/views/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void loadNewCoffee() {
    context.read<CoffeeCubit>().getRandomCoffee();
  }

  void saveCoffee(Coffee coffee) {
    context.read<CoffeeCubit>().save(coffee);
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Very Good Coffee'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, FavoritesScreen.id);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadNewCoffee();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: BlocBuilder<CoffeeCubit, CoffeeState>(
              builder: (context, state) {
                if (state is CoffeeLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is CoffeeError) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.message),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: loadNewCoffee,
                        child: const Text('Try Again'),
                      ),
                    ],
                  );
                }
                if (state is RandomCoffeeLoaded) {
                  final heroTag = 'coffeeImage-${state.coffee.imageUrl}';
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CoffeeImageScreen.id,
                            arguments: {
                              'coffee': state.coffee,
                              'heroTag': heroTag,
                            },
                          );
                        },
                        child: Hero(
                          tag: heroTag,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl: state.coffee.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: loadNewCoffee,
                            icon: const Icon(Icons.refresh),
                            label: const Text('New Image'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () => saveCoffee(state.coffee),
                            icon: const Icon(Icons.favorite),
                            label: const Text('Save Favorite'),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return ElevatedButton(
                  onPressed: loadNewCoffee,
                  child: const Text('Load Coffee'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

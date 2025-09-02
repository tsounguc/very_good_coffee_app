import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/views/coffee_image_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static const String id = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    loadSavedImages();
  }

  void loadSavedImages() {
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state is FavoriteRemoved) {
            loadSavedImages();
          }
        },
        builder: (context, state) {
          if (state is FavoritesLoading) return const Center(child: CircularProgressIndicator());
          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(child: Text('No favorites yet'));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: state.favorites.length,
                itemBuilder: (_, i) {
                  final coffee = state.favorites[i];
                  final heroTag = 'coffeeImage-${coffee.imageUrl}';
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CoffeeImageScreen.id,
                        arguments: {
                          'coffee': coffee,
                          'heroTag': heroTag,
                        },
                      );
                    },
                    child: Hero(
                      tag: heroTag,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: coffee.imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 6,
                            top: 6,
                            child: IconButton(
                              style: IconButton.styleFrom(backgroundColor: Colors.black45),
                              onPressed: () => context.read<FavoritesCubit>().remove(coffee),
                              icon: const Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return const Center(child: Text('No favorites yet'));
        },
      ),
    );
  }
}

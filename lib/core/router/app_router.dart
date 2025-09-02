import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/core/services/service_locator.dart';
import 'package:very_good_coffee_app/features/coffee/domain/entities/coffee.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/coffee_cubit/coffee_cubit.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/views/coffee_image_screen.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/views/favorites_screen.dart';
import 'package:very_good_coffee_app/features/coffee/presentation/views/home_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return _pageBuilder(
          (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => serviceLocator<CoffeeCubit>()..getRandomCoffee(),
              ),
              BlocProvider(
                create: (context) => serviceLocator<FavoritesCubit>(),
              ),
            ],
            child: const HomeScreen(),
          ),
          settings: settings,
        );

      case FavoritesScreen.id:
        return _pageBuilder(
          (context) => BlocProvider(
            create: (context) => serviceLocator<FavoritesCubit>(),
            child: const FavoritesScreen(),
          ),
          settings: settings,
        );

      case CoffeeImageScreen.id:
        final arg = settings.arguments! as Map<String, dynamic>;
        return _pageBuilder(
          (context) => BlocProvider(
            create: (context) => serviceLocator<FavoritesCubit>(),
            child: CoffeeImageScreen(
              coffee: arg['coffee'] as Coffee,
              heroTag: arg['heroTag'] as String,
            ),
          ),
          settings: settings,
        );
      default:
        return _pageBuilder(
          (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}

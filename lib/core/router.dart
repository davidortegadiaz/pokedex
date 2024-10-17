import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/home/view/home_page.dart';
import 'package:pokedex/features/pokemon_detail/view/pokemon_detail_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/pokemonDetailPage',
      builder: (BuildContext context, GoRouterState state) {
        return const PokemonDetailPage();
      },
    ),
  ],
);

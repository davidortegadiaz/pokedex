import 'dart:convert';

import 'package:pokedex/core/injector.dart';
import 'package:pokedex/src/client/pokemon_client_interface.dart';
import 'package:pokedex/src/models/pokemon.dart';

abstract class HomeRepositoryInterface {
  Future<List<Pokemon>> getPokemons();
}

class HomeRepository implements HomeRepositoryInterface {
  @override
  Future<List<Pokemon>> getPokemons() async {
    final response = await injector<PokemonClientInterface>().getPokemons();
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final pokemons = (json['results'] as List)
        .map(
          (pokemon) => Pokemon.fromJson(pokemon as Map<String, dynamic>),
        )
        .toList();

    return pokemons;
  }
}

import 'dart:convert';

import 'package:pokedex/src/client/pokemon_client.dart';
import 'package:pokedex/src/models/pokemon.dart';

class HomeRepository {
  Future<List<Pokemon>> getPokemons() async {
    final response = await PokemonClient().getPokemons();
    final json = jsonDecode(response.body);

    final pokemons = (json['results'] as List)
        .map(
          (pokemon) => Pokemon.fromJson(pokemon),
        )
        .toList();

    return pokemons;
  }
}

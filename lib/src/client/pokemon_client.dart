import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/src/models/pokemon.dart';

class PokemonClient {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<List<Pokemon>> getPokemons() async {
    final queryParameters = {
      'limit': '151',
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    final pokemons = (json['results'] as List)
        .map(
          (pokemon) => Pokemon.fromJson(pokemon),
        )
        .toList();

    return pokemons;
  }
}

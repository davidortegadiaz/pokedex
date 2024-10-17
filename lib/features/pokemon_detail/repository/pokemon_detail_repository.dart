import 'dart:convert';

import 'package:pokedex/core/injector.dart';
import 'package:pokedex/src/client/pokemon_client_interface.dart';
import 'package:pokedex/src/models/pokemon_detail.dart';

abstract class PokemonDetailRepositoryInterface {
  Future<PokemonDetail> getPokemonById(int id);
}

class PokemonDetailRepository implements PokemonDetailRepositoryInterface {
  @override
  Future<PokemonDetail> getPokemonById(int id) async {
    final response =
        await injector<PokemonClientInterface>().getPokemonById(id);
    final json = jsonDecode(response.body);

    final pokemon = PokemonDetail.fromJson(json);

    return pokemon;
  }
}

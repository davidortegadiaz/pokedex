import 'dart:convert';

import 'package:pokedex/core/injector.dart';
import 'package:pokedex/src/models/pokemon_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CapturedPokemonsRepositoryInterface {
  Future<void> capturePokemon(PokemonDetail pokemon);
  Future<void> freePokemon(PokemonDetail pokemon);
  List<PokemonDetail> getCapturedPokemon();
}

class CapturedPokemonsRepository
    implements CapturedPokemonsRepositoryInterface {
  @override
  Future<void> capturePokemon(PokemonDetail pokemon) async {
    final pokemonList = getCapturedPokemon()..add(pokemon);
    final stringList = pokemonList
        .map(
          (pokemon) => jsonEncode(pokemon.toJson()),
        )
        .toList();
    injector<SharedPreferences>().setStringList('items', stringList);
  }

  @override
  Future<void> freePokemon(PokemonDetail pokemon) async {
    final pokemonList = getCapturedPokemon();
    pokemonList.remove(pokemon);
    final stringList = pokemonList
        .map(
          (pokemon) => jsonEncode(pokemon.toJson()),
        )
        .toList();
    injector<SharedPreferences>().setStringList('items', stringList);
  }

  @override
  List<PokemonDetail> getCapturedPokemon() {
    return (injector<SharedPreferences>().getStringList('items') ?? [])
        .map((pokemon) => PokemonDetail.fromLocalJson(jsonDecode(pokemon)))
        .toList();
  }
}

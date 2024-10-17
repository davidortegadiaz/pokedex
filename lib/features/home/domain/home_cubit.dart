import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/src/client/pokemon_client.dart';
import 'package:pokedex/src/models/pokemon.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> getPokemons() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final pokemons = await PokemonClient().getPokemons();
      emit(HomeState(pokemonList: pokemons, status: HomeStatus.success));
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  void filterList(String textFilter) {
    emit(state.copyWith(filter: textFilter.trim()));
    if (state.filter.isEmpty) {
      emit(state.copyWith(filteredPokemonList: []));
    }

    final filterdList = state.pokemonList
        .where((pokemon) => pokemon.name.contains(textFilter))
        .toList();

    emit(state.copyWith(filteredPokemonList: filterdList));
  }
}

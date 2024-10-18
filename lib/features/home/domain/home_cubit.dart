import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/core/pokemon_colors.dart';
import 'package:pokedex/features/home/repository/captured_pokemons_repository.dart';
import 'package:pokedex/features/home/repository/home_repository.dart';
import 'package:pokedex/src/models/pokemon.dart';
import 'package:pokedex/src/models/pokemon_detail.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> getPokemons() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final pokemons = state.pokemonList.isEmpty
          ? await injector<HomeRepositoryInterface>().getPokemons()
          : state.pokemonList;
      final capturedPokemons =
          injector<CapturedPokemonsRepositoryInterface>().getCapturedPokemon();

      emit(
        HomeState(
          pokemonList: pokemons,
          capturedPokemonList: capturedPokemons,
          status: HomeStatus.success,
        ),
      );
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  void filterList(String textFilter) {
    emit(state.copyWith(filter: textFilter.trim()));
    if (state.filter.isEmpty) {
      emit(state.copyWith(filteredPokemonList: []));
      return;
    }

    final filterdList = state.pokemonList
        .where((pokemon) => pokemon.name.contains(textFilter))
        .toList();

    emit(state.copyWith(filteredPokemonList: filterdList));
  }

  Future<void> freePokemon(PokemonDetail pokemon) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await injector<CapturedPokemonsRepositoryInterface>().freePokemon(pokemon);
    emit(
      state.copyWith(
        capturedPokemonList: injector<CapturedPokemonsRepositoryInterface>()
            .getCapturedPokemon(),
        status: HomeStatus.success,
      ),
    );
    sort();
  }

  Future<void> capturePokemon(PokemonDetail pokemon) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await injector<CapturedPokemonsRepositoryInterface>()
        .capturePokemon(pokemon);
    emit(
      state.copyWith(
        capturedPokemonList: injector<CapturedPokemonsRepositoryInterface>()
            .getCapturedPokemon(),
        status: HomeStatus.success,
      ),
    );
    sort();
  }

  Future<void> buttonAction(PokemonDetail pokemon) async {
    state.isCaptured(pokemon.id)
        ? await freePokemon(pokemon)
        : await capturePokemon(pokemon);
  }

  void sortById() {
    emit(state.copyWith(status: HomeStatus.loading));
    final filteredList = state.capturedPokemonList
      ..sort((a, b) => a.id.compareTo(b.id));
    emit(
      state.copyWith(
        capturedPokemonList: filteredList,
        status: HomeStatus.success,
      ),
    );
  }

  void sortByName() {
    emit(state.copyWith(status: HomeStatus.loading));
    final filteredList = state.capturedPokemonList
      ..sort((a, b) => a.name.compareTo(b.name));
    emit(
      state.copyWith(
        capturedPokemonList: filteredList,
        status: HomeStatus.success,
      ),
    );
  }

  void sortByType() {
    emit(state.copyWith(status: HomeStatus.loading));
    final filteredList = state.capturedPokemonList
      ..sort((a, b) => a.types[0].compareTo(b.types[0]));
    emit(
      state.copyWith(
        capturedPokemonList: filteredList,
        status: HomeStatus.success,
      ),
    );
  }

  void sort({CapturedFilters? capturedFilter}) {
    if (capturedFilter != null) {
      emit(state.copyWith(capturedFilter: capturedFilter));
    }
    final filter = capturedFilter ?? state.capturedFilter;
    if (filter == CapturedFilters.id) {
      sortById();
      return;
    }
    filter == CapturedFilters.type ? sortByType() : sortByName();
  }

  void capturedView() => emit(
        state.copyWith(capturedView: !state.capturedView),
      );
}

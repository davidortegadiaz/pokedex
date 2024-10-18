import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/features/home/repository/captured_pokemons_repository.dart';
import 'package:pokedex/features/home/repository/home_repository.dart';
import 'package:pokedex/src/models/pokemon.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> getPokemons() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final pokemons = state.pokemonList.isEmpty
          ? await injector<HomeRepositoryInterface>().getPokemons()
          : state.pokemonList;
      final capturedPokemonIds = injector<CapturedPokemonsRepositoryInterface>()
          .getCapturePokemon()
          .map((id) => int.parse(id))
          .toList();

      final capturedPokemons = pokemons.where((pokemon) {
        return capturedPokemonIds.contains(pokemon.id);
      }).toList();

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

  Future<void> freePokemon(int id) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final pokemonList = state.capturedPokemonList
      ..removeWhere((pokemon) => pokemon.id == id);
    emit(
      state.copyWith(
        capturedPokemonList: pokemonList,
        status: HomeStatus.success,
      ),
    );
    final idList = pokemonList.map((pokemon) => pokemon.id.toString()).toList();
    idList.remove(id.toString());
    await injector<CapturedPokemonsRepositoryInterface>()
        .capturePokemon(idList);
    sort();
  }

  Future<void> capturePokemon(Pokemon pokemon) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final pokemonList = state.capturedPokemonList..add(pokemon);
    final idList =
        injector<CapturedPokemonsRepositoryInterface>().getCapturePokemon();
    idList.add(pokemon.id.toString());
    await injector<CapturedPokemonsRepositoryInterface>()
        .capturePokemon(idList);
    emit(
      state.copyWith(
        capturedPokemonList: pokemonList,
        status: HomeStatus.success,
      ),
    );
    sort();
  }

  Future<void> buttonAction(Pokemon pokemon) async {
    state.isCaptured(pokemon.id)
        ? await freePokemon(pokemon.id)
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

  void sort({CapturedFilters? capturedFilter}) {
    if (capturedFilter != null) {
      emit(state.copyWith(capturedFilter: capturedFilter));
    }
    final filter = capturedFilter ?? state.capturedFilter;
    filter == CapturedFilters.id ? sortById() : sortByName();
  }

  void capturedView() => emit(
        state.copyWith(capturedView: !state.capturedView),
      );
}

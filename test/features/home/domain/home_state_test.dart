import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';
import 'package:pokedex/src/models/pokemon.dart';

void main() {
  group('HomeState', () {
    const List<Pokemon> samplePokemonList = [
      Pokemon(id: 1, name: 'bulbasaur'),
      Pokemon(id: 2, name: 'ivysaur')
    ];

    const List<Pokemon> sampleFilteredPokemonList = [
      Pokemon(id: 1, name: 'bulbasaur')
    ];

    test('supports value comparisons via Equatable', () {
      expect(
        const HomeState(
          pokemonList: samplePokemonList,
          filteredPokemonList: sampleFilteredPokemonList,
          status: HomeStatus.success,
          filter: 'bulb',
        ),
        const HomeState(
          pokemonList: samplePokemonList,
          filteredPokemonList: sampleFilteredPokemonList,
          status: HomeStatus.success,
          filter: 'bulb',
        ),
      );
    });

    test('copyWith maintains unchanged properties', () {
      const originalState = HomeState(
        pokemonList: samplePokemonList,
        filteredPokemonList: sampleFilteredPokemonList,
        status: HomeStatus.success,
        filter: 'bulb',
      );

      final newState = originalState.copyWith(filter: 'ivysaur');

      expect(newState.pokemonList, originalState.pokemonList);
      expect(newState.filteredPokemonList, originalState.filteredPokemonList);
      expect(newState.status, originalState.status);
      expect(newState.filter, 'ivysaur');
    });

    test('copyWith updates the correct properties', () {
      const originalState = HomeState(
        pokemonList: samplePokemonList,
        status: HomeStatus.initial,
      );

      final newState = originalState.copyWith(
        pokemonList: sampleFilteredPokemonList,
        status: HomeStatus.loading,
      );

      expect(newState.pokemonList, sampleFilteredPokemonList);
      expect(newState.status, HomeStatus.loading);
    });

    test('loading getter returns true when status is loading', () {
      const loadingState = HomeState(status: HomeStatus.loading);

      expect(loadingState.loading, isTrue);
    });

    test('error getter returns true when status is error', () {
      const errorState = HomeState(status: HomeStatus.error);

      expect(errorState.error, isTrue);
    });

    test('pokemons getter returns pokemonList if filter is empty', () {
      const state = HomeState(
        pokemonList: samplePokemonList,
        filter: '',
      );

      expect(state.pokemons, samplePokemonList);
    });

    test('pokemons getter returns filteredPokemonList if filter is not empty',
        () {
      const state = HomeState(
        pokemonList: samplePokemonList,
        filteredPokemonList: sampleFilteredPokemonList,
        filter: 'bulb',
      );

      expect(state.pokemons, sampleFilteredPokemonList);
    });
  });
}

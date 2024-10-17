part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Pokemon> pokemonList;
  final List<Pokemon> filteredPokemonList;
  final HomeStatus status;
  final String filter;

  const HomeState({
    this.pokemonList = const <Pokemon>[],
    this.filteredPokemonList = const <Pokemon>[],
    this.status = HomeStatus.initial,
    this.filter = '',
  });

  @override
  List<Object?> get props => [pokemonList, status, filteredPokemonList, filter];

  HomeState copyWith({
    List<Pokemon>? pokemonList,
    List<Pokemon>? filteredPokemonList,
    HomeStatus? status,
    String? filter,
  }) {
    return HomeState(
      pokemonList: pokemonList ?? this.pokemonList,
      status: status ?? this.status,
      filteredPokemonList: filteredPokemonList ?? this.filteredPokemonList,
      filter: filter ?? this.filter,
    );
  }

  bool get loading => status == HomeStatus.loading;
  bool get error => status == HomeStatus.error;

  List<Pokemon> get pokemons =>
      filter.isEmpty ? pokemonList : filteredPokemonList;
}

enum HomeStatus { initial, loading, success, error }

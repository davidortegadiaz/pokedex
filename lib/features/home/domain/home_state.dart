part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Pokemon> pokemonList;
  final List<Pokemon> filteredPokemonList;
  final List<PokemonDetail> capturedPokemonList;
  final HomeStatus status;
  final String filter;
  final bool capturedView;
  final CapturedFilters capturedFilter;

  const HomeState({
    this.pokemonList = const <Pokemon>[],
    this.filteredPokemonList = const <Pokemon>[],
    this.capturedPokemonList = const <PokemonDetail>[],
    this.status = HomeStatus.initial,
    this.filter = '',
    this.capturedView = false,
    this.capturedFilter = CapturedFilters.id,
  });

  @override
  List<Object?> get props => [
        pokemonList,
        status,
        filteredPokemonList,
        capturedPokemonList,
        filter,
        capturedView,
        capturedFilter,
      ];

  HomeState copyWith({
    List<Pokemon>? pokemonList,
    List<Pokemon>? filteredPokemonList,
    List<PokemonDetail>? capturedPokemonList,
    HomeStatus? status,
    String? filter,
    bool? capturedView,
    CapturedFilters? capturedFilter,
  }) {
    return HomeState(
      pokemonList: pokemonList ?? this.pokemonList,
      status: status ?? this.status,
      filteredPokemonList: filteredPokemonList ?? this.filteredPokemonList,
      capturedPokemonList: capturedPokemonList ?? this.capturedPokemonList,
      filter: filter ?? this.filter,
      capturedView: capturedView ?? this.capturedView,
      capturedFilter: capturedFilter ?? this.capturedFilter,
    );
  }

  bool get loading => status == HomeStatus.loading;
  bool get error => status == HomeStatus.error;
  bool isCaptured(int id) => capturedPokemonList.any(
        (pokemon) => pokemon.id == id,
      );

  List<Pokemon> get pokemons => capturedView
      ? capturedPokemonList
          .map((pokemon) => Pokemon(id: pokemon.id, name: pokemon.name))
          .toList()
      : (filter.isEmpty ? pokemonList : filteredPokemonList);

  String get capturedButtonText => capturedView ? 'Captured' : 'All';
}

enum HomeStatus { initial, loading, success, error }

enum CapturedFilters { id, name, type }

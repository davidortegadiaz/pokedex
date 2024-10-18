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

  Color get themeColor {
    final list = <String>[];

    for (final pokemon in capturedPokemonList) {
      list.addAll(pokemon.types);
    }
    Map<String, int> frequencyMap = {};

    // Count occurrences of each string
    for (var item in list) {
      frequencyMap[item] = (frequencyMap[item] ?? 0) + 1;
    }

    // Find the maximum count and track the strings that have that count
    int maxCount = 0;
    List<String> mostRepeated = [];

    frequencyMap.forEach((key, value) {
      if (value > maxCount) {
        maxCount = value;
        mostRepeated = [key]; // Start a new list with the new max
      } else if (value == maxCount) {
        mostRepeated.add(key); // Add to the list of most repeated items
      }
    });

    // If there's more than one item with the max count, return 'defaultColor'
    if (mostRepeated.length > 1) {
      return PokemonColors.defaultColor;
    }

    // Return the most repeated string
    return PokemonColorByType.colorByType(
      mostRepeated.first,
    ); // If there's a clear winner, return it
  }
}

enum HomeStatus { initial, loading, success, error }

enum CapturedFilters { id, name, type }

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';
import 'package:pokedex/features/home/repository/home_repository.dart';
import 'package:pokedex/src/models/pokemon.dart';

class MockHomeRepository extends Mock implements HomeRepositoryInterface {}

void main() {
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    // Ensure the injector returns the mocked repository
    GetIt injector = GetIt.instance;
    injector.registerSingleton<HomeRepositoryInterface>(
      mockHomeRepository,
    );
  });

  tearDown(() {
    injector.unregister(instance: mockHomeRepository);
  });

  group('HomeCubit', () {
    const List<Pokemon> samplePokemonList = [
      Pokemon(id: 1, name: 'bulbasaur'),
      Pokemon(id: 2, name: 'ivysaur')
    ];

    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when getPokemons succeeds',
      build: () {
        // Arrange: mock the successful getPokemons call
        when(() => mockHomeRepository.getPokemons())
            .thenAnswer((_) async => samplePokemonList);
        return HomeCubit();
      },
      act: (cubit) => cubit.getPokemons(),
      expect: () => [
        const HomeState(status: HomeStatus.loading), // First state: loading
        HomeState(
            pokemonList: samplePokemonList,
            status: HomeStatus.success), // Then success
      ],
      verify: (_) {
        // Verify the getPokemons method was called once
        verify(() => mockHomeRepository.getPokemons()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, error] when getPokemons fails',
      build: () {
        // Arrange: mock the failure case
        when(() => mockHomeRepository.getPokemons())
            .thenThrow(Exception('API Error'));
        return HomeCubit();
      },
      act: (cubit) => cubit.getPokemons(),
      expect: () => [
        const HomeState(status: HomeStatus.loading), // First state: loading
        const HomeState(status: HomeStatus.error), // Then error state
      ],
      verify: (_) {
        // Verify that getPokemons was called once
        verify(() => mockHomeRepository.getPokemons()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits correct filtered list when filterList is called',
      build: () => HomeCubit(),
      seed: () => HomeState(
        pokemonList: samplePokemonList,
        status: HomeStatus.success,
      ),
      act: (cubit) => cubit.filterList('bulb'),
      expect: () => [
        HomeState(
          filter: 'bulb',
          pokemonList: samplePokemonList,
          status: HomeStatus.success,
        ),
        HomeState(
          pokemonList: samplePokemonList,
          status: HomeStatus.success,
          filter: 'bulb',
          filteredPokemonList: [
            samplePokemonList[0]
          ], // The filtered list only contains "bulbasaur"
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits empty filteredPokemonList when filterList is called with empty string',
      build: () => HomeCubit(),
      seed: () => HomeState(
        pokemonList: samplePokemonList,
        status: HomeStatus.success,
        filter: 'bulb',
      ),
      act: (cubit) => cubit.filterList(''),
      expect: () => [
        HomeState(
          pokemonList: samplePokemonList,
          status: HomeStatus.success,
          filter: '',
          filteredPokemonList: [],
        ),
      ],
    );
  });
}

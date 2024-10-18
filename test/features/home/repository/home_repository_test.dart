import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/features/home/repository/home_repository.dart';
import 'package:pokedex/src/client/pokemon_client_interface.dart';
import 'package:pokedex/src/models/pokemon.dart';

// Step 1: Create a Mock for PokemonClientInterface
class MockPokemonClient extends Mock implements PokemonClientInterface {}

void main() {
  late HomeRepository homeRepository;
  late MockPokemonClient mockPokemonClient;

  setUp(() {
    // Initialize the mock client
    mockPokemonClient = MockPokemonClient();
    GetIt.instance.registerLazySingleton<PokemonClientInterface>(
      () => mockPokemonClient,
    );

    // Create the HomeRepository instance to be tested
    homeRepository = HomeRepository();
  });

  tearDown(() {
    injector.unregister(instance: mockPokemonClient);
  });

  group('HomeRepository', () {
    test('should return a list of Pokemon when API call is successful',
        () async {
      // Arrange
      const fakeApiResponse = '''
        {
          "results": [
            {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
            {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"}
          ]
        }
      ''';

      // Set up the mock to return a successful response
      when(() => injector<PokemonClientInterface>().getPokemons())
          .thenAnswer((_) async => Response(fakeApiResponse, 200));

      // Act
      final pokemons = await homeRepository.getPokemons();

      // Assert
      expect(pokemons, isA<List<Pokemon>>());
      expect(pokemons.length, 2);
      expect(pokemons[0].name, 'bulbasaur');
      expect(pokemons[0].id, 1);
      expect(pokemons[1].name, 'ivysaur');
      expect(pokemons[1].id, 2);
    });

    test('should throw an error when API call fails', () async {
      // Arrange
      when(() => injector<PokemonClientInterface>().getPokemons())
          .thenThrow(Exception('API Error'));

      // Act & Assert
      expect(() => homeRepository.getPokemons(), throwsA(isA<Exception>()));
    });
  });
}

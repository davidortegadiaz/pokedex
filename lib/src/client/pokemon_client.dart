import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pokedex/src/client/pokemon_client_interface.dart';

class PokemonClient implements PokemonClientInterface {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  @override
  Future<Response> getPokemons() async {
    final queryParameters = {
      'limit': '151',
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response = await client.get(uri);
    return response;
  }
}

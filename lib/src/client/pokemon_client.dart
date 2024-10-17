import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PokemonClient {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<Response> getPokemons() async {
    final queryParameters = {
      'limit': '151',
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response = await client.get(uri);
    return response;
  }
}

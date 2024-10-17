import 'package:http/http.dart';

abstract class PokemonClientInterface {
  Future<Response> getPokemons();
}

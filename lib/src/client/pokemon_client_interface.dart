import 'package:http/http.dart';

abstract class PokemonClientInterface {
  Future<Response> getPokemons();
  Future<Response> getPokemonById(int id);
}

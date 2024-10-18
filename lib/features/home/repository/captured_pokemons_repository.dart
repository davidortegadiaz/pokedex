import 'package:pokedex/core/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CapturedPokemonsRepositoryInterface {
  Future<void> capturePokemon(List<String> ids);
  List<String> getCapturePokemon();
}

class CapturedPokemonsRepository
    implements CapturedPokemonsRepositoryInterface {
  @override
  Future<void> capturePokemon(List<String> ids) async {
    await injector<SharedPreferences>().setStringList('items', ids);
  }

  @override
  List<String> getCapturePokemon() {
    return injector<SharedPreferences>().getStringList('items') ?? [];
  }
}

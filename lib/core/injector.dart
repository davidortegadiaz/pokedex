import 'package:get_it/get_it.dart';
import 'package:pokedex/features/home/repository/home_repository.dart';
import 'package:pokedex/src/client/pokemon_client.dart';
import 'package:pokedex/src/client/pokemon_client_interface.dart';

GetIt injector = GetIt.instance;

void setupInjector() {
  injector
    ..registerLazySingleton<PokemonClientInterface>(() => PokemonClient())
    ..registerLazySingleton<HomeRepositoryInterface>(() => HomeRepository());
}

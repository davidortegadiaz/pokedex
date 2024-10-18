import 'package:get_it/get_it.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';
import 'package:pokedex/features/home/repository/captured_pokemons_repository.dart';
import 'package:pokedex/features/home/repository/home_repository.dart';
import 'package:pokedex/features/pokemon_detail/repository/pokemon_detail_repository.dart';
import 'package:pokedex/src/client/pokemon_client.dart';
import 'package:pokedex/src/client/pokemon_client_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt injector = GetIt.instance;

void setupInjector() {
  injector
    ..registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    )
    ..registerLazySingleton<PokemonClientInterface>(() => PokemonClient())
    ..registerLazySingleton<HomeRepositoryInterface>(() => HomeRepository())
    ..registerLazySingleton<PokemonDetailRepositoryInterface>(
      () => PokemonDetailRepository(),
    )
    ..registerLazySingleton<CapturedPokemonsRepositoryInterface>(
      () => CapturedPokemonsRepository(),
    )
    ..registerLazySingleton<HomeCubit>(
      () => HomeCubit()..getPokemons(),
    );
}

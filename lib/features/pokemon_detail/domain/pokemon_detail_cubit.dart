import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/features/pokemon_detail/repository/pokemon_detail_repository.dart';
import 'package:pokedex/src/models/pokemon_detail.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  PokemonDetailCubit() : super(const PokemonDetailState());

  Future<void> getPokemonById(int id) async {
    emit(state.copyWith(status: PokemonDetailStatus.loading));
    try {
      final pokemon =
          await injector<PokemonDetailRepositoryInterface>().getPokemonById(id);
      emit(
        PokemonDetailState(
          pokemon: pokemon,
          status: PokemonDetailStatus.success,
        ),
      );
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      emit(state.copyWith(status: PokemonDetailStatus.error));
    }
  }
}

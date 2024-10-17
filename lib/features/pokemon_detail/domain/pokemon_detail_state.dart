part of 'pokemon_detail_cubit.dart';

class PokemonDetailState extends Equatable {
  final PokemonDetail? pokemon;
  final PokemonDetailStatus status;

  const PokemonDetailState({
    this.pokemon,
    this.status = PokemonDetailStatus.initial,
  });

  @override
  List<Object?> get props => [pokemon, status];

  PokemonDetailState copyWith({
    PokemonDetail? pokemon,
    PokemonDetailStatus? status,
  }) {
    return PokemonDetailState(
      pokemon: pokemon ?? this.pokemon,
      status: status ?? this.status,
    );
  }

  bool get loading => status == PokemonDetailStatus.loading;
  bool get error => status == PokemonDetailStatus.error;
  bool get success => status == PokemonDetailStatus.success;
}

enum PokemonDetailStatus { initial, loading, success, error }

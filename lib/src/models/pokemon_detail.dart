import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/pokemon_colors.dart';
import 'package:pokedex/src/models/stat.dart';

class PokemonDetail extends Equatable {
  final int id;
  final String name;
  final int weight;
  final int height;
  final List<String> types;
  final List<String> moves;
  final List<Stat> stats;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.types,
    required this.moves,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'] as String,
      weight: json['weight'],
      height: json['height'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      moves: (json['moves'] as List)
          .map((type) => type['move']['name'] as String)
          .take(2)
          .toList(),
      stats: (json['stats'] as List)
          .map(
            (type) => Stat.fromJson(type),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, weight, height, types, moves];

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$id.svg';

  Color get backgroundColor => PokemonColorByType.colorByType(types[0]);

  @override
  bool? get stringify => true;
}

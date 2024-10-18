// ignore_for_file: avoid_dynamic_calls

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/pokemon_colors.dart';
import 'package:pokedex/src/models/stat.dart';

class PokemonDetail extends Equatable {
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
      id: json['id'] as int,
      name: json['name'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      moves: (json['moves'] as List)
          .map((type) => type['move']['name'] as String)
          .take(2)
          .toList(),
      stats: (json['stats'] as List<dynamic>)
          .map(
            (map) => Stat.fromJson(map as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  factory PokemonDetail.fromLocalJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
      types: List.from(json['types'] as List),
      moves: List.from(json['moves'] as List),
      stats: (json['stats'] as List)
          .map(
            (json) => Stat.fromLocalJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
  final int id;
  final String name;
  final int weight;
  final int height;
  final List<String> types;
  final List<String> moves;
  final List<Stat> stats;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'types': types,
      'moves': moves,
      'stats': stats.map((stat) => stat.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, name, weight, height, types, moves];

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$id.svg';

  Color get backgroundColor => PokemonColorByType.colorByType(types[0]);

  @override
  bool? get stringify => true;
}

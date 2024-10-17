import 'package:equatable/equatable.dart';

class PokemonDetail extends Equatable {
  final int id;
  final String name;
  final int weight;
  final int height;
  final List<String> type;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.type,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'] as String,
      weight: json['weight'],
      height: json['height'],
      type: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, weight, height];

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png';

  @override
  bool? get stringify => true;
}

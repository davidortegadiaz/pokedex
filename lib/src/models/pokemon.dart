import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  const Pokemon({required this.id, required this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: int.parse(
        (json['url'] as String).split('/')[6],
      ),
      name: json['name'] as String,
    );
  }
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$id.svg';

  @override
  bool? get stringify => true;
}

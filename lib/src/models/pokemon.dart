import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;

  const Pokemon({required this.id, required this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        id: int.parse(
          (json['url']).split('/')[6],
        ),
        name: json['name'] as String);
  }

  @override
  List<Object?> get props => [id, name];

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png';

  @override
  bool? get stringify => true;
}

import 'package:equatable/equatable.dart';

class Stat extends Equatable {
  final int baseStat;
  final String name;

  const Stat({required this.baseStat, required this.name});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat'],
      name: json['stat']['name'] as String,
    );
  }

  factory Stat.fromLocalJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['baseStat'],
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseStat': baseStat,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [baseStat, name];

  @override
  bool? get stringify => true;
}

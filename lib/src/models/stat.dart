// ignore_for_file: avoid_dynamic_calls

import 'package:equatable/equatable.dart';

class Stat extends Equatable {
  const Stat({required this.baseStat, required this.name});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat'] as int,
      name: json['stat']['name'] as String,
    );
  }

  factory Stat.fromLocalJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['baseStat'] as int,
      name: json['name'] as String,
    );
  }
  final int baseStat;
  final String name;

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

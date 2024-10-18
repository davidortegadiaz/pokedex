import 'package:flutter/material.dart';
import 'package:pokedex/core/pokemon_colors.dart';
import 'package:pokedex/utils/extensions/string_extensions.dart';

class TypeLabel extends StatelessWidget {
  const TypeLabel({required this.type, super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(16),
        color: PokemonColorByType.colorByType(type),
      ),
      child: Text(
        type.capitalize(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

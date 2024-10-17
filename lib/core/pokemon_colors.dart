import 'package:flutter/material.dart';

class PokemonColors {
  static const Color bug = Color(0xFF94bc4a);
  static const Color dark = Color(0xFF736c75);
  static const Color dragon = Color(0xFF6a7baf);
  static const Color electric = Color(0xFFe5c531);
  static const Color fairy = Color(0xFFe397d1);
  static const Color fighting = Color(0xFFcb5f48);
  static const Color fire = Color(0xFFea7a3c);
  static const Color flying = Color(0xFF7da6de);
  static const Color ghost = Color(0xFF846ab6);
  static const Color grass = Color(0xFF71c558);
  static const Color ground = Color(0xFFcc9f4f);
  static const Color ice = Color(0xFF70cbd4);
  static const Color normal = Color(0xFFaab09f);
  static const Color poison = Color(0xFFb468b7);
  static const Color psychic = Color(0xFFe5709b);
  static const Color rock = Color(0xFFb2a061);
  static const Color steel = Color(0xFF89a1b0);
  static const Color water = Color(0xFF539ae2);
  static const Color defaultColor = Color(0xFFFF0000);
}

enum PokemonColorByType {
  bug(color: PokemonColors.bug),
  dark(color: PokemonColors.dark),
  dragon(color: PokemonColors.dragon),
  electric(color: PokemonColors.electric),
  fairy(color: PokemonColors.fairy),
  fighting(color: PokemonColors.fighting),
  fire(color: PokemonColors.fire),
  flying(color: PokemonColors.flying),
  ghost(color: PokemonColors.ghost),
  grass(color: PokemonColors.grass),
  ground(color: PokemonColors.ground),
  ice(color: PokemonColors.ice),
  normal(color: PokemonColors.normal),
  poison(color: PokemonColors.poison),
  psychic(color: PokemonColors.psychic),
  rock(color: PokemonColors.rock),
  steel(color: PokemonColors.steel),
  water(color: PokemonColors.water);

  const PokemonColorByType({required this.color});

  final Color color;

  static Color colorByType(String type) =>
      PokemonColorByType.values.asNameMap()[type]?.color ??
      PokemonColors.defaultColor;
}

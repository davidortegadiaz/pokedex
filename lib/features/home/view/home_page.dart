import 'package:flutter/material.dart';
import 'package:pokedex/core/pokemon_colors.dart';
import 'package:pokedex/features/home/view/widgets/home_app_bar.dart';
import 'package:pokedex/features/home/view/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PokemonColors.defaultColor,
        appBar: AppBar(
          toolbarHeight: 130,
          elevation: 0,
          flexibleSpace: HomeAppBar(),
        ),
        body: HomeBody(),
      ),
    );
  }
}

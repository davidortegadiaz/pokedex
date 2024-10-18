import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';
import 'package:pokedex/features/pokemon_detail/view/widgets/moves.dart';
import 'package:pokedex/features/pokemon_detail/view/widgets/pokemon_height.dart';
import 'package:pokedex/features/pokemon_detail/view/widgets/pokemon_weight.dart';
import 'package:pokedex/features/pokemon_detail/view/widgets/stats.dart';
import 'package:pokedex/features/pokemon_detail/view/widgets/type_label.dart';
import 'package:pokedex/src/models/pokemon_detail.dart';
import 'package:pokedex/utils/widgets/separator.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({required this.pokemon, super.key});

  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .68,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                pokemon.types.map((type) => TypeLabel(type: type)).toList(),
          ),
          Text(
            'About',
            style: TextStyle(
              color: pokemon.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PokemonWeight(weight: pokemon.weight),
                Separator(),
                PokemonHeight(height: pokemon.height),
                Separator(),
                Moves(
                  moves: pokemon.moves,
                ),
              ],
            ),
          ),
          Text(
            'Base Stats',
            style: TextStyle(
              color: pokemon.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Stats(
            stats: pokemon.stats,
            color: pokemon.backgroundColor,
          ),
          CapturedButton(pokemon: pokemon),
        ],
      ),
    );
  }
}

class CapturedButton extends StatelessWidget {
  const CapturedButton({required this.pokemon, super.key});

  final PokemonDetail pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: injector<HomeCubit>(),
      builder: (context, state) {
        return InkWell(
          onTap: () => injector<HomeCubit>().buttonAction(
            pokemon,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: pokemon.backgroundColor.withOpacity(
                state.isCaptured(pokemon.id) ? .4 : 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              state.isCaptured(pokemon.id) ? 'Free' : 'Captured',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

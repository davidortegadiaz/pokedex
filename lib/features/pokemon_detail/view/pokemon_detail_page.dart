import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon_detail/domain/pokemon_detail_cubit.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailCubit()..getPokemonById(id),
      child: PokemonDetailPageView(),
    );
  }
}

class PokemonDetailPageView extends StatelessWidget {
  const PokemonDetailPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.error) {
            return Center(child: Text('There has been an error'));
          }
          return Center(
            child: Text(state.pokemon!.name),
          );
        },
      ),
    );
  }
}

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';
import 'package:pokedex/src/models/pokemon.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: injector<HomeCubit>(),
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error) {
          return const Center(child: Text('There has been an error'));
        }
        final list = state.pokemons;
        return ColoredBox(
          color: state.themeColor,
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Platform.isWindows ? 10 : 3,
                childAspectRatio: 100 / 110,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final pokemon = list[index];
                return HomeBodyItem(pokemon: pokemon);
              },
            ),
          ),
        );
      },
    );
  }
}

class HomeBodyItem extends StatelessWidget {
  const HomeBodyItem({required this.pokemon, super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return InkWell(
          splashColor: Colors.transparent,
          onTap: () => context.push('/pokemonDetailPage', extra: pokemon.id),
          child: Card(
            clipBehavior: Clip.hardEdge,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: constraints.maxHeight * .4,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      border: Border.all(
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
                Image(
                  height: constraints.maxHeight * .5,
                  image: Svg(
                    pokemon.imageUrl,
                    source: SvgSource.network,
                  ),
                ),
                Positioned(bottom: 0, child: Text(pokemon.name)),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '#${pokemon.id}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

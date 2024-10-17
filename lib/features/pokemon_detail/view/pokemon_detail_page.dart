import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:pokedex/features/pokemon_detail/domain/pokemon_detail_cubit.dart';
import 'package:pokedex/features/pokemon_detail/view/widgets/detail_body.dart';
import 'package:pokedex/utils/extensions/string_extensions.dart';

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
    return BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: state.pokemon?.backgroundColor,
              foregroundColor: Colors.white,
              title: Row(
                children: [
                  Text(
                    state.pokemon?.name.capitalize() ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    '#${state.pokemon?.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: state.pokemon?.backgroundColor,
            body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
              builder: (context, state) {
                if (state.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.error) {
                  return Center(child: Text('There has been an error'));
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(4),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: DetailBody(pokemon: state.pokemon!),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * .55,
                        left: 0,
                        right: 0,
                        child: DetailImage(image: state.pokemon!.imageUrl),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class DetailImage extends StatelessWidget {
  const DetailImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image(
      width: 150,
      height: 150,
      image: Svg(
        image,
        source: SvgSource.network,
      ),
    );
  }
}

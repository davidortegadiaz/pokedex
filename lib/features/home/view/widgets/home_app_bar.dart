import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 150,
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.catching_pokemon,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: 8),
              Text(
                'Pokédex',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            height: 32,
            child: TextField(
              onChanged: BlocProvider.of<HomeCubit>(context).filterList,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                hintText: 'Search',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

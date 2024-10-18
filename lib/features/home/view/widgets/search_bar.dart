import 'package:flutter/material.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onChanged: injector<HomeCubit>().filterList,
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
    );
  }
}

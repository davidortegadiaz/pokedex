import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/core/pokemon_colors.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: injector<HomeCubit>(),
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 150,
          color: PokemonColors.defaultColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.catching_pokemon,
                    color: Colors.white,
                    size: 32,
                  ),
                  Text(
                    'Pokédex',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: injector<HomeCubit>().capturedView,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Text(
                        state.capturedButtonText,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
              if (state.capturedView)
                Row(
                  children: [
                    DropdownButton<CapturedFilters>(
                      dropdownColor: PokemonColors.defaultColor,
                      value: state.capturedFilter,
                      iconEnabledColor: Colors.white,
                      underline: SizedBox(),
                      items: CapturedFilters.values
                          .map<DropdownMenuItem<CapturedFilters>>(
                              (CapturedFilters value) {
                        return DropdownMenuItem<CapturedFilters>(
                          value: value,
                          child: Text(
                            value.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (CapturedFilters? value) {
                        injector<HomeCubit>().sort(capturedFilter: value);
                      },
                    ),
                  ],
                )
              else
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
                ),
            ],
          ),
        );
      },
    );
  }
}

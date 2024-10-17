import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/home/domain/home_cubit.dart';
import 'package:pokedex/features/home/view/widgets/home_app_bar.dart';
import 'package:pokedex/features/home/view/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getPokemons(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          toolbarHeight: 120,
          flexibleSpace: HomeAppBar(),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.error) {
              return Center(child: Text('Ha habido un error'));
            }
            return HomeBody();
          },
        ),
      ),
    );
  }
}

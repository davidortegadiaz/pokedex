import 'package:flutter/material.dart';
import 'package:pokedex/core/injector.dart';
import 'package:pokedex/core/router.dart';

void main() {
  setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

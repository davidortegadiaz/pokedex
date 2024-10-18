import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class PokemonWeight extends StatelessWidget {
  const PokemonWeight({required this.weight, super.key});

  final int weight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          MediaQuery.of(context).size.width * (Platform.isWindows ? .1 : .25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.scale, size: 18),
              const SizedBox(width: 4),
              Text('$weight'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Weight',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

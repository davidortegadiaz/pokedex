import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class PokemonHeight extends StatelessWidget {
  const PokemonHeight({required this.height, super.key});

  final int height;

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
              const Icon(Icons.straighten, size: 18),
              const SizedBox(width: 4),
              Text('$height'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Height',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

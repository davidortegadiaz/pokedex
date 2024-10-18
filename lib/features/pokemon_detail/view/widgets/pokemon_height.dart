import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class PokemonHeight extends StatelessWidget {
  const PokemonHeight({required this.height, super.key});

  final int height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (Platform.isWindows ? .1 : .2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.straighten, size: 18),
              SizedBox(width: 4),
              Text('$height'),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Height',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

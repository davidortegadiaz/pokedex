import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:pokedex/utils/extensions/string_extensions.dart';

class Moves extends StatelessWidget {
  const Moves({required this.moves, super.key});

  final List<String> moves;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (Platform.isWindows ? .1 : .2),
      child: Column(
        children: [
          Text(
            moves[0].capitalize(),
          ),
          Text(
            moves[1].capitalize(),
          ),
          SizedBox(height: 4),
          Text(
            'Moves',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

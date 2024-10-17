import 'package:flutter/material.dart';

class Moves extends StatelessWidget {
  const Moves({required this.moves, super.key});

  final List<String> moves;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .27,
      child: Column(
        children: [
          Text(
            moves[0],
          ),
          Text(
            moves[1],
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

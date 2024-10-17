import 'package:flutter/material.dart';

class PokemonWeight extends StatelessWidget {
  const PokemonWeight({required this.weight, super.key});

  final int weight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.scale, size: 18),
              SizedBox(width: 4),
              Text('$weight'),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Weight',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

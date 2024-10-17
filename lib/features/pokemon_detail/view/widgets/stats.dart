import 'package:flutter/material.dart';
import 'package:pokedex/src/models/stat.dart';
import 'package:pokedex/utils/widgets/separator.dart';

class Stats extends StatelessWidget {
  const Stats({
    super.key,
    required this.stats,
    required this.color,
  });

  final List<Stat> stats;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stats
              .map(
                (stat) => Text(
                  stat.name,
                  style: TextStyle(color: color),
                ),
              )
              .toList(),
        ),
        Separator(height: 120),
        Column(
          children: stats
              .map(
                (stat) => Text(
                  stat.baseStat.toString(),
                ),
              )
              .toList(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: stats
              .map(
                (stat) => Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: stat.baseStat.toDouble() / 100,
                      color: color,
                      backgroundColor: color.withOpacity(.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

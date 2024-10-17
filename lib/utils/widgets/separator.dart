import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({this.height, super.key});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: 1,
      color: Colors.grey.withOpacity(.5),
    );
  }
}

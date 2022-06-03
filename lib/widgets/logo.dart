//this page specifies constants for the project
import 'dart:math';

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  const Logo({
    required this.color,
    required this.size,
  });
//returning logo through the function
  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/proceso_logo.png", height: 75, width: 50);
  }
}

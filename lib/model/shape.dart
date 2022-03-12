import 'package:flutter/material.dart';
import 'package:subdivide/model/face.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:subdivide/view/unit_to_screen.dart';

class Shape extends StatelessWidget {
  const Shape({Key? key, required this.faces}) : super(key: key);

  final List<Face> faces;

  @override
  Widget build(BuildContext context) {
    return const UnitToScreen(
        child: Triangle(
      offsets: offsets,
      color: Colors.purple,
    ));
  }
}

const offsets = [Offset(0, 0), Offset(1, 0), Offset(0, 1)];

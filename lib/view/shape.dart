import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subdivide/model/face.dart';
import 'package:subdivide/model/math_3d.dart';
import 'package:subdivide/vertices.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:subdivide/view/unit_to_screen.dart';
import 'package:vector_math/vector_math_64.dart' as vecmath;

import 'triangle.dart';

class Shape extends StatelessWidget {
  const Shape({Key? key, required this.faces}) : super(key: key);

  final List<Face> faces;

  @override
  Widget build(BuildContext context) {
    return UnitToScreen(child: Stack(children: _calcTriangles(context)));
  }

  List<Triangle> _calcTriangles(BuildContext context) {
    final vertices = getVertices(context);
    final triangles = <Triangle>[];

    for (final face in faces) {
      var a = vertices[face.a];
      var b = vertices[face.b];
      var c = vertices[face.c];

      var normal = Math3d.normal(a, b, c).normalized();
      final light = vecmath.Vector3(0.0, 0.0, 1.0);

      var brightness = normal.dot(light).clamp(0.0, 1.0);
      const Color color = Colors.purple;

      triangles.add(Triangle(
        offsets: [getOffset(a), getOffset(b), getOffset(c)],
        color: Color.fromARGB(
            255,
            (brightness * color.red).toInt(),
            (brightness * color.green).toInt(),
            (brightness * color.blue).toInt()),
      ));
    }
    return triangles;
  }
}

Offset getOffset(vecmath.Vector3 v) => Offset(v.x, v.y);
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:subdivide/model/math_3d.dart';
import 'package:subdivide/model/shape_data.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:subdivide/view/unit_to_screen.dart';
import 'package:subdivide/view/vertex_notifier.dart';
import 'package:vector_math/vector_math_64.dart' as vecmath;

import 'triangle.dart';

const noWarn = out;

class Shape extends StatelessWidget {
  const Shape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnitToScreen(child: Stack(children: _calcTriangles(context)));
  }

  List<Triangle> _calcTriangles(BuildContext context) {
    final shapeData = getShapeData(context, listen: false);

    final vertexNotifier = getVertexNotifier(context, listen: true);
    final transform = vertexNotifier.transform;

    final vertices = vertexNotifier.vertices;
    final vertices2 = vertexNotifier.vertices2;

    for (int i = 0; i < shapeData.vertices.length; ++i) {
      vertices[i] = transform.transformed3(shapeData.vertices[i], vertices[i]);
    }

    for (int i = 0; i < shapeData.vertices2.length; ++i) {
      vertices2[i] =
          transform.transformed3(shapeData.vertices2[i], vertices2[i]);
    }

    final triangles = <Triangle>[];

    for (final mesh in shapeData.meshes) {
      final Color color = mesh.dark ? Colors.brown : Colors.white60;

      for (final face in mesh.faces) {
        final a = face.a2 ? vertices2[face.a] : vertices[face.a];
        final b = face.b2 ? vertices2[face.b] : vertices[face.b];
        final c = face.c2 ? vertices2[face.c] : vertices[face.c];

        final normal = Math3d.normal(a, b, c).normalized();

        if (0 < normal.z) {
          final light = vecmath.Vector3(0.0, 0.0, 1.0);

          final brightness = normal.dot(light).clamp(0.0, 1.0);

          triangles.add(Triangle(
            offsets: [_flipY(a), _flipY(b), _flipY(c)],
            color: Color.fromARGB(
                255,
                (brightness * color.red).toInt(),
                (brightness * color.green).toInt(),
                (brightness * color.blue).toInt()),
          ));
        }
      }
    }
    return triangles;
  }
}

Offset _flipY(vecmath.Vector3 v) => Offset(v.x, -v.y);

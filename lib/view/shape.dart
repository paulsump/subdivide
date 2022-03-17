import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subdivide/model/math_3d.dart';
import 'package:subdivide/model/shape_data.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:subdivide/view/vertex_notifier.dart';
import 'package:vector_math/vector_math_64.dart' as vecmath;

import 'triangle.dart';

const noWarn = [out];

get _light => vecmath.Vector3(0.0, 0.0, 1.0).normalized();

class Shape extends StatelessWidget {
  const Shape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: _calcTriangles(context));
  }

  List<Triangle> _calcTriangles(BuildContext context) {
    final shapeData = getShapeData(context, listen: false);

    final vertexNotifier = getVertexNotifier(context, listen: true);

    final vertices = vertexNotifier.vertices;
    final vertices2 = vertexNotifier.vertices2;

    final triangles = <Triangle>[];

    for (final mesh in shapeData.meshes) {
      final Color color = mesh.dark ? Colors.blueGrey : Colors.white60;

      for (final face in mesh.faces) {
        final a = face.a2 ? vertices2[face.a] : vertices[face.a];
        final b = face.b2 ? vertices2[face.b] : vertices[face.b];
        final c = face.c2 ? vertices2[face.c] : vertices[face.c];

        if (a.z > 0 || b.z > 0 || c.z > 0) {
          final normal = Math3d.normal(a, b, c).normalized();

          if (0 < normal.z) {
            final offsets = <Offset>[_flipY(a), _flipY(b), _flipY(c)];
            final colors = <Color>[
              _getColor(a, face.a2, a, b, c, color),
              _getColor(b, face.b2, a, b, c, color),
              _getColor(c, face.c2, a, b, c, color),
            ];

            triangles.add(Triangle(offsets: offsets, colors: colors));
          }
        }
      }
    }
    return triangles;
  }
}

Color _getColor(
  vecmath.Vector3 vertex,
  bool flat,
  vecmath.Vector3 a,
  vecmath.Vector3 b,
  vecmath.Vector3 c,
  Color color,
) {
  final vertexNormal = vertex.normalized();
  final vertexBrightness = vertexNormal.dot(_light).clamp(0.0, 1.0);

  var brightness = vertexBrightness;
  if (flat) {
    final faceNormal = Math3d.normal(a, b, c).normalized();

    final faceBrightness = faceNormal.dot(_light).clamp(0.0, 1.0);
    brightness = lerpDouble(brightness, faceBrightness, 0.3)!;
  }

  return Color.fromARGB(255, (brightness * color.red).toInt(),
      (brightness * color.green).toInt(), (brightness * color.blue).toInt());
}

Offset _flipY(vecmath.Vector3 v) => Offset(v.x, -v.y);

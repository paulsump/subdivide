import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subdivide/model/math_3d.dart';
import 'package:subdivide/model/shape_data.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/triangles.dart';
import 'package:subdivide/view/vertex_notifier.dart';
import 'package:vector_math/vector_math_64.dart' as vec_math;

import 'triangles.dart';

const noWarn = [out];

get _light => vec_math.Vector3(0.0, 0.0, 1.0).normalized();

/// The football widget
class Shape extends StatelessWidget {
  const Shape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shapeData = getShapeData(context, listen: false);

    final vertexNotifier = getVertexNotifier(context, listen: true);

    final vertices = vertexNotifier.vertices;
    final seamVertices = vertexNotifier.seamVertices;

    final offsets = <Offset>[];
    final colors = <Color>[];

    for (final mesh in shapeData.meshes) {
      final Color color = mesh.isDark ? Colors.blueGrey : Colors.white60;

      for (final face in mesh.faces) {
        final a = face.aSeam ? seamVertices[face.a] : vertices[face.a];
        final b = face.bSeam ? seamVertices[face.b] : vertices[face.b];
        final c = face.cSeam ? seamVertices[face.c] : vertices[face.c];

        if (a.z > 0 || b.z > 0 || c.z > 0) {
          final normal = Math3d.normal(a, b, c).normalized();

          if (0 < normal.z) {
            offsets.addAll(<Offset>[_flipY(a), _flipY(b), _flipY(c)]);
            colors.addAll(<Color>[
              _getColor(a, face.aSeam, a, b, c, color),
              _getColor(b, face.bSeam, a, b, c, color),
              _getColor(c, face.cSeam, a, b, c, color),
            ]);
          }
        }
      }
    }
    return Triangles(offsets: offsets, colors: colors);
  }
}

Color _getColor(
  vec_math.Vector3 vertex,
  bool flat,
  vec_math.Vector3 a,
  vec_math.Vector3 b,
  vec_math.Vector3 c,
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

Offset _flipY(vec_math.Vector3 v) => Offset(v.x, -v.y);

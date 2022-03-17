import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart' as vecmath;

const noWarn = out;

class Triangle extends StatelessWidget {
  const Triangle({
    Key? key,
    required this.a,
    required this.b,
    required this.c,
    required this.color_,
  }) : super(key: key);

  final vecmath.Vector3 a, b, c;
  final Color color_;

  @override
  Widget build(BuildContext context) {
    final offsets = <Offset>[_flipY(a), _flipY(b), _flipY(c)];
    final colors = <Color>[_getColor(a), _getColor(b), _getColor(c)];

    return CustomPaint(
      painter: _Painter(
        Vertices(
          VertexMode.triangles,
          offsets,
          colors: colors,
        ),
      ),
    );
  }

  Color _getColor(vecmath.Vector3 vertex) {
    final normal = vertex.normalized();

    final light = vecmath.Vector3(0.0, 0.0, 1.0);
    final brightness = normal.dot(light).clamp(0.0, 1.0);

    return Color.fromARGB(
        255,
        (brightness * color_.red).toInt(),
        (brightness * color_.green).toInt(),
        (brightness * color_.blue).toInt());
  }
}

Offset _flipY(vecmath.Vector3 v) => Offset(v.x, -v.y);

/// The painter for [Triangle].
class _Painter extends CustomPainter {
  const _Painter(this.vertices);

  final Vertices vertices;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawVertices(vertices, BlendMode.srcOver, _redPaint);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => true;
}

final _redPaint = Paint()
  ..color = Colors.red
  ..style = PaintingStyle.stroke;

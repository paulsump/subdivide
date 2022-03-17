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
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke,
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

/// The painter for [Ball].
class _Painter extends CustomPainter {
  const _Painter(this.vertices, this.paint_, this.paintStroke_);

  final Paint paint_;
  final Paint paintStroke_;
  final Vertices vertices;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawPath(path, paint_);
    // canvas.drawPath(path, paintStroke_);
    canvas.drawVertices(
      vertices,
      BlendMode.srcOver,
      Paint()..color = Colors.red,
      // paint_,
    );
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => true;
}

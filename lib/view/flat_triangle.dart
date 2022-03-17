import 'dart:core';

import 'package:flutter/material.dart';
import 'package:subdivide/model/math_3d.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:vector_math/vector_math_64.dart' as vecmath;

const noWarn = out;

class FlatTriangle extends StatelessWidget {
  const FlatTriangle({
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
    final aBrightness = a.dot(light).clamp(0.0, 1.0);
    final bBrightness = b.dot(light).clamp(0.0, 1.0);
    final cBrightness = c.dot(light).clamp(0.0, 1.0);
    final normal = Math3d.normal(a, b, c).normalized();

    final brightness = (aBrightness +
            bBrightness +
            cBrightness +
            normal.dot(light).clamp(0.0, 1.0)) /
        4;

    final offsets = <Offset>[_flipY(a), _flipY(b), _flipY(c)];

    final color = Color.fromARGB(
        255,
        (brightness * color_.red).toInt(),
        (brightness * color_.green).toInt(),
        (brightness * color_.blue).toInt());

    return CustomPaint(
      painter: _Painter(
        Path()..addPolygon(offsets, true),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke,
      ),
    );
  }
}

Offset _flipY(vecmath.Vector3 v) => Offset(v.x, -v.y);

/// The painter for [FlatTriangle].
class _Painter extends CustomPainter {
  const _Painter(this.path, this.paint_, this.paintStroke_);

  final Path path;
  final Paint paint_;
  final Paint paintStroke_;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path, paint_);
    canvas.drawPath(path, paintStroke_);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => true;
}

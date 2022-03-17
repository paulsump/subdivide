import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:vector_math/vector_math_64.dart' as vecmath;

const noWarn = out;

class SeamTriangle extends StatelessWidget {
  const SeamTriangle({
    Key? key,
    required this.a,
    required this.b,
    required this.c,
    required this.aOrigin,
    required this.bOrigin,
    required this.cOrigin,
    required this.color_,
  }) : super(key: key);

  final vecmath.Vector3 a, b, c;
  final vecmath.Vector3? aOrigin;
  final vecmath.Vector3? bOrigin;
  final vecmath.Vector3? cOrigin;
  final Color color_;

  @override
  Widget build(BuildContext context) {
    final offsets = <Offset>[_flipY(a), _flipY(b), _flipY(c)];
    // final offsets = <Offset>[_flipY(aOrigin??a), _flipY(bOrigin??b), _flipY(cOrigin??c)];
    final colors = <Color>[
      _getColor(a, aOrigin),
      _getColor(b, bOrigin),
      _getColor(c, cOrigin)
    ];

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

  Color _getColor(vecmath.Vector3 vertex, vecmath.Vector3? origin) {
    final normal =
        origin == null ? vertex.normalized() : (vertex - origin).normalized();
// if(origin != null){
//   out(   vertex - origin);
// }
    final brightness = normal.dot(light).clamp(0.0, 1.0);

    return Color.fromARGB(
        255,
        (brightness * color_.red).toInt(),
        (brightness * color_.green).toInt(),
        (brightness * color_.blue).toInt());
  }
}

Offset _flipY(vecmath.Vector3 v) => Offset(v.x, -v.y);

/// The painter for [SeamTriangle].
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

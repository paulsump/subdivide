import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subdivide/out.dart';
// import 'package:vector_math/vector_math_64.dart' as vecmath;

const noWarn = out;

class ConstShape extends StatelessWidget {
  const ConstShape({
    Key? key,
    // required this.name,
  }) : super(key: key);

  // final String name;

  @override
  Widget build(BuildContext context) {
    // final triangles = <ConstTriangle>[];

    return const CustomPaint(
      painter: _Painter(
          // Path()..addPolygon(offsets, true),
          // Paint()
          //   ..color = color
          //   ..style = PaintingStyle.fill,
          // Paint()
          //   ..color = color
          //   ..style = PaintingStyle.stroke,
          ),
    );
  }
}

// Offset _flipY(vecmath.Vector3 v) => Offset(v.x, -v.y);

/// The painter for [Ball].
class _Painter extends CustomPainter {
  const _Painter(// this.path,
      // this.paint_,
      // this.paintStroke_,
      );

  // final Path path;
  // final Paint paint_;
  // final Paint paintStroke_;

  @override
  void paint(Canvas canvas, Size size) {
    // for (final triangle in triangles) {
    //   canvas.drawPath(path, paint_);
    //   canvas.drawPath(path, paintStroke_);
    // }
    var vertices = Vertices(
      VertexMode.triangles,
      [Offset.zero, const Offset(100, 0), const Offset(100, 100)],
      colors: [Colors.red, Colors.green, Colors.blue],
    );

    canvas.translate(20, 50);
    canvas.drawVertices(
      vertices,
      BlendMode.srcOver,
      Paint()..color = Colors.red,
    );
    canvas.translate(20, 50);
    canvas.drawVertices(
      vertices,
      BlendMode.srcOver,
      Paint()..color = Colors.green,
    );
    canvas.translate(20, 50);
    canvas.drawVertices(
      vertices,
      BlendMode.srcOver,
      Paint()..color = Colors.blue,
    );
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => false;
}

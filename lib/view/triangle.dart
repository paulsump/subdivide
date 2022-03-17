import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:subdivide/out.dart';

const noWarn = out;

class Triangle extends StatelessWidget {
  const Triangle({
    Key? key,
    required this.offsets,
    required this.colors,
  }) : super(key: key);

  final List<Offset> offsets;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
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
}

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

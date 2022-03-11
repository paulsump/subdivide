// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/face.dart';

class Ball extends StatelessWidget {
  const Ball({Key? key, required this.tris}) : super(key: key);

  final List<Tri> tris;

  // tris = <Tri>[];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        faces: tris.map(
          (tri) => Face(
            path: Path()..addPolygon(getOffsets(tri), true),
            paint: getPaint(tri),
          ),
        ),
      ),
    );
  }
}

class Face {
  const Face({required this.path, required this.paint});

  final Path path;
  final Paint paint;
}

List<Offset> getOffsets(Tri tri) {
  return [];
}

Paint getPaint(Tri tri, {PaintingStyle style = PaintingStyle.fill}) => Paint()
  ..color = tri.color
  ..style = style;

/// The painter for [Ball].
class _Painter extends CustomPainter {
  const _Painter({required this.faces});

  final Iterable<Face> faces;

  @override
  void paint(Canvas canvas, Size size) {
    for (final face in faces) {
      canvas.drawPath(face.path, face.paint);
    }
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => false;
}

// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/model/tri.dart';
import 'package:subdivide/view/face.dart';

class Ball extends StatelessWidget {
  const Ball({Key? key, required this.tris}) : super(key: key);

  final List<Tri> tris;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        faces: tris.map(
          (tri) => Face.fromTri(tri),
        ),
      ),
    );
  }
}

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

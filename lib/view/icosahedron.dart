// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/model/tri.dart';
import 'package:subdivide/view/face.dart';

class Icosahedron extends StatefulWidget {
  const Icosahedron({Key? key, required this.tris}) : super(key: key);

  final List<Tri> tris;

  @override
  _IcosahedronState createState() => _IcosahedronState();
}

class _IcosahedronState extends State<Icosahedron>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        faces: widget.tris.map(
          (tri) => Face.fromTri(tri),
        ),
      ),
    );
  }
}

/// The painter for [Icosahedron].
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

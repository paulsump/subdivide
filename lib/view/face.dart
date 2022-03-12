// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/model/tri.dart';

class Face {
  const Face({required this.path, required this.paint});

  Face.fromTri(Tri tri)
      : this(
            path: Path()..addPolygon(getOffsets(tri), true),
            paint: getPaint(tri));

  final Path path;
  final Paint paint;
}

// TODO matrix4 provider,
// TODO transform3(vertex) all the vertices first
// TODO icosahedronVertices
List<Offset> getOffsets(Tri tri) {
  return [];
}

Paint getPaint(Tri tri, {PaintingStyle style = PaintingStyle.fill}) => Paint()
  ..color = getColor(tri)
  ..style = style;

Color getColor(Tri tri) {
  return Colors.purple;
}

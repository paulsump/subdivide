// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:subdivide/model/face.dart';
import 'package:subdivide/model/shape_notifier.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

ShapeData generateShapeData() => ShapeData(
      vertices: [
        Vector3(0, 0, 0),
        Vector3(1, 0, 0),
        Vector3(0, 1, 0),
      ],
      faces: const [Face(0, 1, 2)],
    );

const noWarn = out;

const root5 = 2.23606797749979;

// https://youtu.be/xMh_LtlOs_4?t=69
// https://mathworld.wolfram.com/RegularPentagon.html
// https://www.youtube.com/watch?v=xMh_LtlOs_4&ab_channel=MechanicalMachineDesign

const double c1 = (root5 - 1) / 4;
const double c2 = (root5 + 1) / 4;

const double s1 = 0.9510565162951535; //sqrt(10+2*root5)/4;
const double s2 = 0.5877852522924731; //sqrt(10-2*root5)/4;

class Vertex {
  final double x, y, z;

  const Vertex(this.x, this.y, this.z);
}

/// vertices of a unit icosahedron.
const icosahedronVertices = <Vertex>[
//north pole (z)
  Vertex(0, 0, root5 / 2),
// top pentagon
  Vertex(0, 1, 0.5),
  Vertex(-s1, c1, 0.5),
  Vertex(-s2, -c2, 0.5),
  Vertex(s2, -c2, 0.5),
  Vertex(s1, c1, 0.5),

  // bottom pentagon
  Vertex(0, -1, -0.5),
  Vertex(-s1, -c1, -0.5),
  Vertex(-s2, c2, -0.5),
  Vertex(s2, c2, -0.5),
  Vertex(s1, -c1, -0.5),

  // south pole
  Vertex(0, 0, -root5 / 2),
];

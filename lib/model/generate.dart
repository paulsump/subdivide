import 'dart:core';

import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

const root5 = 2.23606797749979;

// https://youtu.be/xMh_LtlOs_4?t=69
// https://mathworld.wolfram.com/RegularPentagon.html

const double c1 = (root5 - 1) / 4;
const double c2 = (root5 + 1) / 4;

const double s1 = 0.9510565162951535; //sqrt(10+2*root5)/4;
const double s2 = 0.5877852522924731; //sqrt(10-2*root5)/4;

class Vertex {
  final double x, y, z;

  const Vertex(this.x, this.y, this.z);
}

/// vertices of a unit octahedron.
const vertices = <Vertex>[
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

/// (An octahedron that fits into a unit cube).
List<Vector3> generateIcosahedron() {
  return [];
}

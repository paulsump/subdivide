// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:subdivide/model/shape_data.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

// ShapeData generateShapeData() => icosahedron;
ShapeData generateShapeData() =>
    // subdivide(icosahedron);
    subdivideFrequency3(icosahedron);

int _getOrAdd(Vector3 vector3, List<Vector3> vertices) {
  int index = vertices.length;

  // TODO only add IF not found
  vertices.add(vector3);
  return index;
}

/// for each vector coming out from a vertex
/// go a third of the way along and add that ver (do face the same time)
ShapeData subdivideFrequency3(ShapeData old) {
  final vertices = <Vector3>[...old.vertices];

  final dark = <Face>[];
  final light = <Face>[];

  final darkMesh = Mesh(faces: dark, dark: true);
  final lightMesh = Mesh(faces: light, dark: false);

  for (final face in old.meshes.first.faces) {
    // face corners
    final a = vertices[face.a];
    final b = vertices[face.b];
    final c = vertices[face.c];

    // edge vectors
    final p = b - a;
    final q = c - b;
    final r = a - c;

    // one third along edge
    final int p1 = _getOrAdd(a + p / 3, vertices);
    final int q1 = _getOrAdd(b + q / 3, vertices);
    final int r1 = _getOrAdd(c + r / 3, vertices);

    // two thirds along edge
    final int p2 = _getOrAdd(a + p * 2 / 3, vertices);
    final int q2 = _getOrAdd(b + q * 2 / 3, vertices);
    final int r2 = _getOrAdd(c + r * 2 / 3, vertices);

    // centre
    final int s = _getOrAdd((a + b + c) / 3, vertices);

    // outer 3 are dark
    dark.add(Face(face.a, p1, r2));
    dark.add(Face(face.b, q1, p2));
    dark.add(Face(face.c, r1, q2));
    // this will make the smooth corners of the patch (the round bit at the end of the seam

    // inner 6 are light
    light.add(Face(p1, s, r2));
    light.add(Face(p2, s, p1));
    light.add(Face(q1, s, p2));
    light.add(Face(q2, s, q1));
    light.add(Face(r1, s, q2));
    light.add(Face(r2, s, r1));
    // later can pull in the first 12 vertices in.
    // later, putting in the seam in a straight line is easy (sacrifice corner?)
  }

  for (final vertex in vertices) {
    vertex.normalize();
  }

  return ShapeData(vertices: vertices, meshes: [darkMesh, lightMesh]);
  return icosahedron;
}

ShapeData subdivide(ShapeData old) {
  final vertices = <Vector3>[...old.vertices];
  final faces = <Face>[];

  for (final face in old.meshes.first.faces) {
    final a = vertices[face.a];
    final b = vertices[face.b];
    final c = vertices[face.c];

    final p = (a + b) / 2;
    final q = (b + c) / 2;
    final r = (c + a) / 2;

    final i = vertices.length;
    vertices.add(p);

    final j = vertices.length;
    vertices.add(q);

    final k = vertices.length;
    vertices.add(r);

    faces.add(Face(face.a, i, k));
    faces.add(Face(i, face.b, j));
    faces.add(Face(j, face.c, k));
    faces.add(Face(k, i, j));
  }
  for (final vertex in vertices) {
    vertex.normalize();
  }
  return ShapeData(
      vertices: vertices, meshes: <Mesh>[Mesh(faces: faces, dark: false)]);
}

const noWarn = out;

const root5 = 2.23606797749979;

// https://youtu.be/xMh_LtlOs_4?t=69
// https://mathworld.wolfram.com/RegularPentagon.html
// https://www.youtube.com/watch?v=xMh_LtlOs_4&ab_channel=MechanicalMachineDesign

const double c1 = (root5 - 1) / 4;
const double c2 = (root5 + 1) / 4;

const double s1 = 0.9510565162951535; //sqrt(10+2*root5)/4;
const double s2 = 0.5877852522924731; //sqrt(10-2*root5)/4;

//TODO remove HACK for quick hot reload
// final icosahedron = ShapeData(
ShapeData get icosahedron => ShapeData(vertices: <Vector3>[
      // north pole (z)
      Vector3(0, 0, root5 / 2),

      // top pentagon from top anticlockwise
      Vector3(0, 1, 0.5),
      Vector3(-s1, c1, 0.5),
      Vector3(-s2, -c2, 0.5),
      Vector3(s2, -c2, 0.5),
      Vector3(s1, c1, 0.5),

      // bottom pentagon from top anticlockwise
      Vector3(-s2, c2, -0.5),
      Vector3(-s1, -c1, -0.5),
      Vector3(0, -1, -0.5),
      Vector3(s1, -c1, -0.5),
      Vector3(s2, c2, -0.5),

      // south pole
      Vector3(0, 0, -root5 / 2),
    ], meshes: <Mesh>[
      const Mesh(
        faces: [
          // top
          Face(0, 1, 2),
          Face(0, 2, 3),
          Face(0, 3, 4),
          Face(0, 4, 5),
          Face(0, 5, 1),

          // bottom
          Face(11, 10, 9),
          Face(11, 9, 8),
          Face(11, 8, 7),
          Face(11, 7, 6),
          Face(11, 6, 10),

          // top between
          Face(1, 6, 2),
          Face(2, 7, 3),
          Face(3, 8, 4),
          Face(4, 9, 5),
          Face(5, 10, 1),

          // bottom between
          Face(6, 7, 2),
          Face(7, 8, 3),
          Face(8, 9, 4),
          Face(9, 10, 5),
          Face(10, 6, 1),
        ],
        dark: false,
      )
    ]);

final triangle = ShapeData(vertices: [
  Vector3(0, 0, 0),
  Vector3(1, 0, 0),
  Vector3(0, 1, 0),
], meshes: <Mesh>[
  const Mesh(
    faces: [Face(0, 1, 2)],
    dark: false,
  )
]);

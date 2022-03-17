import 'dart:core';

import 'package:flutter/material.dart';
import 'package:subdivide/model/math_3d.dart';
import 'package:subdivide/model/shape_data.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/flat_triangle.dart';
import 'package:subdivide/view/seam_triangle.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:subdivide/view/vertex_notifier.dart';

import 'triangle.dart';

const noWarn = [out, SeamTriangle];

class Shape extends StatelessWidget {
  const Shape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // ..._calcSeamTriangles(context),
      ..._calcFlatTriangles(context),
      ..._calcTriangles(context),
    ]);
  }

  List<Triangle> _calcTriangles(BuildContext context) {
    final shapeData = getShapeData(context, listen: false);

    final vertexNotifier = getVertexNotifier(context, listen: true);

    final vertices = vertexNotifier.vertices;
    final vertices2 = vertexNotifier.vertices2;

    final triangles = <Triangle>[];

    for (final mesh in shapeData.meshes) {
      final Color color = mesh.dark ? Colors.blueGrey : Colors.white60;

      for (final face in mesh.faces) {
        if (face.a2 || face.b2 || face.c2) {
          // if (true) {
          continue;
        }

        final a = face.a2 ? vertices2[face.a] : vertices[face.a];
        final b = face.b2 ? vertices2[face.b] : vertices[face.b];
        final c = face.c2 ? vertices2[face.c] : vertices[face.c];

        if (a.z > 0 || b.z > 0 || c.z > 0) {
          final normal = Math3d.normal(a, b, c).normalized();

          if (0 < normal.z) {
            triangles.add(Triangle(a: a, b: b, c: c, color_: color));
          }
        }
      }
    }
    return triangles;
  }

  List<FlatTriangle> _calcFlatTriangles(BuildContext context) {
    final shapeData = getShapeData(context, listen: false);

    final vertexNotifier = getVertexNotifier(context, listen: true);

    final vertices = vertexNotifier.vertices;
    final vertices2 = vertexNotifier.vertices2;

    final triangles = <FlatTriangle>[];

    for (final mesh in shapeData.meshes) {
      final Color color = mesh.dark ? Colors.blueGrey : Colors.white60;

      for (final face in mesh.faces) {
        if (face.a2 || face.b2 || face.c2) {
          final a = face.a2 ? vertices2[face.a] : vertices[face.a];
          final b = face.b2 ? vertices2[face.b] : vertices[face.b];
          final c = face.c2 ? vertices2[face.c] : vertices[face.c];

          if (a.z > 0 || b.z > 0 || c.z > 0) {
            final normal = Math3d.normal(a, b, c).normalized();

            if (0 < normal.z) {
              triangles.add(FlatTriangle(a: a, b: b, c: c, color_: color));
            }
          }
        }
      }
    }
    return triangles;
  }

  /// TODO instead of flat triangles, just work out that correct
  /// vertex normals for the seams.
  List<SeamTriangle> _calcSeamTriangles(BuildContext context) {
    final shapeData = getShapeData(context, listen: false);

    final vertexNotifier = getVertexNotifier(context, listen: true);

    final vertices = vertexNotifier.vertices;
    final vertices2 = vertexNotifier.vertices2;

    final triangles = <SeamTriangle>[];

    for (final mesh in shapeData.meshes) {
      final Color color = mesh.dark ? Colors.blueGrey : Colors.white60;

      for (final face in mesh.faces) {
        if (face.a2 || face.b2 || face.c2) {
          final a = face.a2 ? vertices2[face.a] : vertices[face.a];
          final b = face.b2 ? vertices2[face.b] : vertices[face.b];
          final c = face.c2 ? vertices2[face.c] : vertices[face.c];

          if (a.z > 0 || b.z > 0 || c.z > 0) {
            final normal = Math3d.normal(a, b, c).normalized();
            if (0 < normal.z) {
              triangles.add(SeamTriangle(
                a: a,
                b: b,
                c: c,
                color_: color,
                aOrigin: face.a2 ? face.origin : null,
                bOrigin: face.b2 ? face.origin : null,
                cOrigin: face.c2 ? face.origin : null,
                // aOrigin: face.a2 ? face.transformedOrigin : null,
                // bOrigin: face.b2 ? face.transformedOrigin : null,
                // cOrigin: face.c2 ? face.transformedOrigin : null,
                // aOrigin: face.transformedOrigin,
                // bOrigin: face.transformedOrigin,
                // cOrigin: face.transformedOrigin,
              ));
            }
          }
        }
      }
    }
    return triangles;
  }
}

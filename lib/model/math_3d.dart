// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:vector_math/vector_math_64.dart';

/// Static helper functions
class Math3d {
  /// face normal from three vertices on the plane.
  /// (usually the corners of a triangle)
  /// The result is not normalised.
  static Vector3 normal(Vector3 a, Vector3 b, Vector3 c) {
    // TODO change the direction of these

    final Vector3 bVector = b - a;
    final Vector3 cVector = c - a;

    return bVector.cross(cVector);
  }

  /// Calculate the sum of the z values of a face.  Used during
  /// sorting and rendering to draw faces in order from
  /// back to front.
// static double sumZ(Vector3 p1, Vector3 p2, Vector3 p3) {
//   return p1.z + p2.z + p3.z;
// }
}

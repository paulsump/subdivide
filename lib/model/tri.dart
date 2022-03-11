// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

/// A colored 3d triangle.
/// TODO REname to ColoredTriangle
class Tri {
  const Tri(this.a, this.b, this.c, this.color);

  final Vector3 a, b, c;
  final Color color;
}

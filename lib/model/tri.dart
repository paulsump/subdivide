// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:subdivide/out.dart';

const noWarn = out;

/// A 3d triangular facet.
/// Made from 3 vertex indices
class Tri {
  const Tri(this.a, this.b, this.c);

  final int a, b, c;
}

// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/model/face.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

ShapeNotifier getShapeNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<ShapeNotifier>(context, listen: listen);

/// Access to the Shape data.
/// Generated by something, drawn by something else.
class ShapeNotifier extends ChangeNotifier {
  final List<Vector3> _vertices = [
    Vector3(0, 0, 0),
    Vector3(1, 0, 0),
    Vector3(0, 1, 0)
  ];

  final List<Face> _faces = [const Face(0, 1, 2)];

  List<Vector3> get vertices => _vertices;
  List<Face> get faces => _faces;

  // void init(List<Vector3> vertices
}

// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

List<Vector3> getVertices(BuildContext context, {bool listen = false}) =>
    getVertexNotifier(context, listen: listen).vertices;

void setVertices(BuildContext context, List<Vector3> vertices) =>
    getVertexNotifier(context, listen: false).setOffset(vertices);

VertexNotifier getVertexNotifier(BuildContext context,
        {required bool listen}) =>
    Provider.of<VertexNotifier>(context, listen: listen);

/// Stores the global vertices.
/// They are moved by something, drawn by something else.
class VertexNotifier extends ChangeNotifier {
  List<Vector3> _vertices = [
    Vector3(0, 0, 0),
    Vector3(1, 0, 0),
    Vector3(0, 1, 0)
  ];

  List<Vector3> get vertices => _vertices;

  void setOffset(List<Vector3> value) {
    _vertices = value;
    notifyListeners();
  }
}

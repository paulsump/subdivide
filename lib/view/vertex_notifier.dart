// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';

Matrix4 getTransform(BuildContext context, {required bool listen}) =>
    getVertexNotifier(context, listen: listen).transform;

void setTransform(Matrix4 transform, BuildContext context) =>
    getVertexNotifier(context, listen: false).setTransform(transform);

VertexNotifier getVertexNotifier(BuildContext context,
    {required bool listen}) =>
    Provider.of<VertexNotifier>(context, listen: listen);

class VertexNotifier extends ChangeNotifier {
  Matrix4 _transform = Matrix4.identity();

  late List<Vector3> vertices;
  late List<Vector3> vertices2;

  Matrix4 get transform => _transform;

  void setTransform(Matrix4 transform) {
    _transform = transform;
    notifyListeners();
  }

  void init(List<Vector3> list, List<Vector3> list2) {
    vertices = list;
    vertices2 = list2;
  }
}

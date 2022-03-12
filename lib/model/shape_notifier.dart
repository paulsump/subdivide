// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/model/face.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

class ShapeData {
  const ShapeData(this.vertices, this.faces);

  final List<Vector3> vertices;

  final List<Face> faces;
}

ShapeData getShapeData(BuildContext context,  {required bool listen}) =>
getShapeNotifier(context, listen:listen).shapeData;

ShapeNotifier getShapeNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<ShapeNotifier>(context, listen: listen);

/// Access to the [ShapeData].
/// Generated in generate.dart, drawn by [Shape].
class ShapeNotifier extends ChangeNotifier {
  final List<Vector3> _vertices = [
    Vector3(0, 0, 0),
    Vector3(1, 0, 0),
    Vector3(0, 1, 0)
  ];

  final List<Face> _faces = [const Face(0, 1, 2)];

  List<Vector3> get vertices => _vertices;
  List<Face> get faces => _faces;

late  ShapeData _shapeData;
  ShapeData get shapeData=>_shapeData;
  void init(ShapeData shapeData_){
    _shapeData = shapeData_;}
}

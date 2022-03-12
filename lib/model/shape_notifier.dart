// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/model/face.dart';
import 'package:subdivide/model/generate.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

class ShapeData {
  const ShapeData({required this.vertices, required this.faces});

  final List<Vector3> vertices;

  final List<Face> faces;
}

ShapeData getShapeData(BuildContext context, {required bool listen}) =>
    getShapeNotifier(context, listen: listen).shapeData;

ShapeNotifier getShapeNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<ShapeNotifier>(context, listen: listen);

/// Access to the [ShapeData].
/// Generated in generate.dart, drawn by [Shape].
class ShapeNotifier extends ChangeNotifier {
  // late ShapeData _shapeData;

  // ShapeData get shapeData => _shapeData;
  //TODO remove HACK for quick hot reaload
  ShapeData get shapeData => generateShapeData();

  void init(ShapeData shapeData_) {
    // _shapeData = shapeData_;
  }
}

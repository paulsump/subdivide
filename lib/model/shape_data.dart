// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/model/generate.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

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

class ShapeData {
  const ShapeData({
    required this.vertices,
    required this.faces,
  });

  final List<Vector3> vertices;

  final List<Face> faces;

  ShapeData.fromString(String json) : this.fromJson(jsonDecode(json));

  @override
  String toString() => jsonEncode(this);

  ShapeData.fromJson(Map<String, dynamic> json)
      : vertices = json['vertices']
            .map<Vector3>(
              (v) => Vector3Persist.fromJson(v),
            )
            .toList(),
        faces = json['cubes']
            .map<Face>(
              (f) => Face.fromJson(f),
            )
            .toList();

  Map<String, dynamic> toJson() => {
        'vertices': vertices.map((v) => Vec3(v)).toList(),
        'faces': faces,
      };
}

class Vector3Persist {
  static Vector3 fromJson(Map<String, dynamic> json) =>
      Vector3(json['x'], json['y'], json['z']);
}

class Vec3 {
  Vec3(Vector3 v)
      : x = v.x,
        y = v.y,
        z = v.z;
  final double x, y, z;

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'z': z};
}

class Face {
  const Face(this.a, this.b, this.c);

  final int a, b, c;

  Face.fromJson(Map<String, dynamic> json)
      : a = json['a'],
        b = json['b'],
        c = json['c'];

  Map<String, dynamic> toJson() => {'a': a, 'b': b, 'c': c};
}

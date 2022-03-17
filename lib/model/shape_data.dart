// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/model/generate.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = [out, generateShapeData];

ShapeData getShapeData(BuildContext context, {required bool listen}) =>
    getShapeNotifier(context, listen: listen).shapeData;

ShapeNotifier getShapeNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<ShapeNotifier>(context, listen: listen);

/// Access to the [ShapeData].
/// Generated in generate.dart, drawn by [Shape].
class ShapeNotifier extends ChangeNotifier {
  late ShapeData _shapeData;

  ShapeData get shapeData => _shapeData;

  //TODO remove HACK for quick hot reaload
  // ShapeData get shapeData => generateShapeData();

  void init(ShapeData shapeData_) {
    _shapeData = shapeData_;
  }
}

class ShapeData {
  const ShapeData({
    required this.vertices,
    required this.vertices2,
    required this.meshes,
  });

  final List<Vector3> vertices;
  final List<Vector3> vertices2;

  final List<Mesh> meshes;

  ShapeData.fromString(String json) : this.fromJson(jsonDecode(json));

  @override
  String toString() => jsonEncode(this);

  ShapeData.fromJson(Map<String, dynamic> json)
      : vertices = json['vertices']
            .map<Vector3>(
              (v) => Vertex.fromJson(v),
            )
            .toList(),
        vertices2 = json['vertices']
            .map<Vector3>(
              (v) => Vertex.fromJson(v),
            )
            .toList(),
        meshes = json['meshes']
            .map<Mesh>(
              (m) => Mesh.fromJson(m),
            )
            .toList();

  Map<String, dynamic> toJson() => {
        'vertices': vertices.map((v) => Vertex(v)).toList(),
        'vertices2': vertices2.map((v) => Vertex(v)).toList(),
        'meshes': meshes
            .map(
              (m) => m.toJson(),
            )
            .toList(),
      };
}

class Mesh {
  const Mesh({
    required this.faces,
    required this.dark,
  });

  final List<Face> faces;

  final bool dark;

  Mesh.fromString(String json) : this.fromJson(jsonDecode(json));

  @override
  String toString() => jsonEncode(this);

  Mesh.fromJson(Map<String, dynamic> json)
      : faces = json['faces']
            .map<Face>(
              (f) => Face.fromJson(f),
            )
            .toList(),
        dark = json.containsKey('dark') ? json['dark'] : 0;

  Map<String, dynamic> toJson() =>
      {
        'faces': faces,
        'dark': dark,
      };
}

//TODO maybe use this class from json + const constructor
class Vertex {
  Vertex(Vector3 v)
      : x = v.x,
        y = v.y,
        z = v.z;
  final double x, y, z;

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'z': z};

  static Vector3 fromJson(Map<String, dynamic> json) =>
      Vector3(json['x'], json['y'], json['z']);
}

class Face {
  const Face(
    this.a,
    this.b,
    this.c, {
    this.a2 = false,
    this.b2 = false,
    this.c2 = false,
  });

  final int a, b, c;
  final bool a2, b2, c2;

  Face.fromJson(Map<String, dynamic> json)
      : a = json['a'],
        b = json['b'],
        c = json['c'],
        a2 = json['a2'],
        b2 = json['b2'],
        c2 = json['c2'];

  Map<String, dynamic> toJson() => {
        'a': a,
        'b': b,
        'c': c,
        'a2': a2,
        'b2': b2,
        'c2': c2,
      };
}

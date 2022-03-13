// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:convert';
import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:subdivide/model/shape_data.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = [out, Vector3];

void main() {
  group('json empty', () {
    const testJson = '{"vertices": [],"faces": []}';

    test('load', () {
      Map<String, dynamic> map = jsonDecode(testJson);
      ShapeData newShapeData = ShapeData.fromJson(map);

      expect(newShapeData.vertices.length, equals(0));
      expect(newShapeData.faces.length, equals(0));
    });

    test('load toString()', () {
      ShapeData newShapeData = ShapeData.fromString(testJson);
      expect(newShapeData.vertices.length, equals(0));
      expect(newShapeData.faces.length, equals(0));
    });
  });

  group('json one face', () {
    // final vertices = <Vector3>[Vector3(1, 2, 3)];
    // final faces = <Face>[const Face(4, 5, 6)];

    // final testShapeData = ShapeData(vertices: vertices, faces: faces);
    const testJson =
        '{"vertices":[{"x":1.0,"y":2.0,"z":3.0}],"faces":[{"a":4,"b":5,"c":6}]}';

    test('load fromString()', () {
      ShapeData newShapeData = ShapeData.fromString(testJson);
      expect(newShapeData.vertices.length, equals(1));
      expect(newShapeData.faces.length, equals(1));
    });
  });
}

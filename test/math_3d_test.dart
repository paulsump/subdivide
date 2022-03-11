// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:subdivide/model/math_3d.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

void main() {
  group('normal', () {
    test('axis', () {
      final xAxis = Vector3(1, 0, 0);

      final yAxis = Vector3(0, 1, 0);
      final zAxis = Vector3(0, 0, 1);

      final normal = Math3d.normal(xAxis, yAxis, zAxis);

      final expected = Vector3(1, 1, 1);
      expect(normal, equals(expected));
    });
  });
}
// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/out.dart';
import 'dart:math';

import 'package:subdivide/view/shape.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

class RotatingShape extends StatefulWidget {
  const RotatingShape({Key? key}) : super(key: key);

  @override
  _RotatingShapeState createState() => _RotatingShapeState();
}

class _RotatingShapeState extends State<RotatingShape>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double get radiansY => _controller.value * pi * 2;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Matrix4 getTransform() {
    const double _scale = 9;

    var transform = Matrix4.translationValues(0, -2, 1);
    transform.scale(_scale, _scale);

    transform.rotateX(radians(10));
    transform.rotateY(radiansY);

    return transform;
  }

  @override
  Widget build(BuildContext context) {
    return Shape(
      transform: getTransform()
    );
  }
}

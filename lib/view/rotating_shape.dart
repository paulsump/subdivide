// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/model/face.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart';

import 'package:subdivide/view/shape.dart';

class RotatingShape extends StatefulWidget {
  const RotatingShape({Key? key}) : super(key: key);

  @override
  _RotatingShapeState createState() => _RotatingShapeState();
}

class _RotatingShapeState extends State<RotatingShape>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  double get radiansY => radians(_controller.value * pi * 2);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shape(
      transform: Matrix4.rotationY(radiansY),
      faces: const [Face(0, 1, 2)],
    );
  }
}

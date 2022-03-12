// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/model/face.dart';
import 'package:subdivide/out.dart';
import 'dart:math';

import 'package:subdivide/view/shape.dart';

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
    // todo shape offset and scale
    // var trans = Matrix4.translationValues(_viewPortX, _viewPortY, 1);
    // trans.scale(_scale, -_scale);
    // return trans;
    return Matrix4.rotationY(radiansY);
  }

  @override
  Widget build(BuildContext context) {
    return Shape(
      transform: getTransform(),
      faces: const [Face(0, 1, 2)],
    );
  }
}

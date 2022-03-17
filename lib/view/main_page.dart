// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/const_shape/const_shape.dart';
import 'package:subdivide/gestures/gesturer.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/horizon.dart';
import 'package:subdivide/view/hue.dart';
import 'package:subdivide/view/rotating_shape.dart';

const noWarn = [out, ConstShape];

/// The only page in this app.
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Hue.background,
        child: SafeArea(
          left: false,
          child: Stack(children: const [
            Horizon(),
            Gesturer(),
            RotatingShape(),
            // ConstShape(),
          ]),
        ),
      ),
    );
  }
}

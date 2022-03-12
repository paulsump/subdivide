// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/gestures/gesturer.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/view/horizon.dart';
import 'package:subdivide/view/hue.dart';
import 'package:subdivide/view/triangle.dart';
import 'package:subdivide/view/unit_to_screen.dart';

const noWarn = [out];

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
            UnitToScreen(
                child: Triangle(
              offsets: offsets,
              color: Colors.purple,
            )),
          ]),
        ),
      ),
    );
  }
}

const offsets = [Offset(0, 0), Offset(1, 0), Offset(0, 1)];

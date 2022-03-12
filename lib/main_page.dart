import 'package:flutter/material.dart';
import 'package:subdivide/gesturer.dart';
import 'package:subdivide/horizon.dart';
import 'package:subdivide/out.dart';
import 'package:subdivide/triangle.dart';
import 'package:subdivide/unit_to_screen.dart';
import 'package:subdivide/view/hue.dart';

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
            UnitToScreen(child: Triangle()),
          ]),
        ),
      ),
    );
  }
}

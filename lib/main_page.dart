import 'package:flutter/material.dart';
import 'package:subdivide/triangle.dart';
import 'package:subdivide/unit_to_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UnitToScreen(child: Triangle());
  }
}

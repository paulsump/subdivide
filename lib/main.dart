// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:subdivide/model/generate.dart';
import 'package:subdivide/model/subdivide.dart';
import 'package:subdivide/view/hue.dart';
import 'package:subdivide/view/screen_adjust.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      Subdivide.subdivide();
      generateIcosahedron();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hue.background,
      body: Center(
        child: ListView(
          children: <Widget>[
            const Text(
              'icosahedron in octahedron:',
            ),
            Image(
                height: screenAdjust(0.7, context),
                image: const AssetImage('images/icosahedron_in_octahedron.png')),
            Image(
                height: screenAdjust(0.7, context),
                image: const AssetImage('images/icosahedron_subdivided_frequency_3.png')),
            Image(
                height: screenAdjust(0.7, context),
                image: const AssetImage('images/truncated_icosahedron.png')),
            Image(
                height: screenAdjust(0.7, context),
                image: const AssetImage('images/geodesic_polyhedron.png')),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'dart:math';

import 'package:subdivide/out.dart';
const noWarn = out;

/// the golden ratio (1 + sqrt(5)) / 2
const phi = 1.618033988749895;

f(){
  final root5 = sqrt(5);
  out((1 + root5) / 2);
}

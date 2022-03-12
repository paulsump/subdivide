// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/out.dart';

const noWarn = out;

Offset getVertices(BuildContext context, {bool listen = false}) =>
    getVertexNotifier(context, listen: listen).vertices;

void setVertices(BuildContext context, Offset vertices) =>
    getVertexNotifier(context, listen: false).setOffset(vertices);

VertexNotifier getVertexNotifier(BuildContext context,
        {required bool listen}) =>
    Provider.of<VertexNotifier>(context, listen: listen);

/// Stores the global vertices.
/// They are moved by something, drawn by something else.
class VertexNotifier extends ChangeNotifier {
  Offset _vertices = Offset.zero;

  Offset get vertices => _vertices;

  void setOffset(Offset value) {
    _vertices = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Matrix4 getTransform(BuildContext context, {required bool listen}) =>
    getVertexNotifier(context, listen: listen).transform;

void setTransform(Matrix4 transform, BuildContext context) =>
    getVertexNotifier(context, listen: false).setTransform(transform);

VertexNotifier getVertexNotifier(BuildContext context,
        {required bool listen}) =>
    Provider.of<VertexNotifier>(context, listen: listen);

class VertexNotifier extends ChangeNotifier {
  late Matrix4 _transform;

  Matrix4 get transform => _transform;

  void setTransform(Matrix4 transform) {
    _transform = transform;
    notifyListeners();
  }
}

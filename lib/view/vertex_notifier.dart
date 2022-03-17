// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subdivide/model/shape_data.dart';
import 'package:subdivide/out.dart';
import 'package:vector_math/vector_math_64.dart';

const noWarn = out;

Matrix4 getTransform(BuildContext context, {required bool listen}) =>
    getVertexNotifier(context, listen: listen).transform;

void setTransform(Matrix4 transform, BuildContext context) =>
    getVertexNotifier(context, listen: false).setTransform(transform, context);

VertexNotifier getVertexNotifier(BuildContext context,
        {required bool listen}) =>
    Provider.of<VertexNotifier>(context, listen: listen);

class VertexNotifier extends ChangeNotifier {
  Matrix4 _transform = Matrix4.identity();

  late List<Vector3> vertices;
  late List<Vector3> vertices2;

  Matrix4 get transform => _transform;

  void setTransform(Matrix4 transform, BuildContext context) {
    _transform = transform;

    final shapeData = getShapeData(context, listen: false);

    for (int i = 0; i < shapeData.vertices.length; ++i) {
      vertices[i] = transform.transformed3(shapeData.vertices[i], vertices[i]);
    }

    for (int i = 0; i < shapeData.vertices2.length; ++i) {
      vertices2[i] =
          transform.transformed3(shapeData.vertices2[i], vertices2[i]);
    }

    for (final mesh in shapeData.meshes) {
      for (final face in mesh.faces) {
        if (face.origin != null && face.transformedOrigin != null) {
          final transformedOrigin =
              transform.transformed3(face.origin!, face.transformedOrigin);
          face.transformedOrigin!.x = transformedOrigin.x;
          face.transformedOrigin!.y = transformedOrigin.y;
          face.transformedOrigin!.z = transformedOrigin.z;
        }
      }
    }
    notifyListeners();
  }

  void init(List<Vector3> list, List<Vector3> list2) {
    vertices = list;
    vertices2 = list2;
  }
}

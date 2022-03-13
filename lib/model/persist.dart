import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:subdivide/model/shape_data.dart';

ShapeData persistedShapeData() {
  return ShapeData.fromString('');
}

/// for loading asset files
class _Assets {
  /// return map of filename + loaded string
  static Future<Map<String, String>> _getStrings(String pathStartsWith) async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');

    final filePaths = <String, String>{};

    for (final String filePath in jsonDecode(manifestJson).keys) {
      if (filePath.startsWith(pathStartsWith)) {
        final fileName = filePath.split('/').last;

        filePaths[fileName] = await rootBundle.loadString(filePath);
      }
    }
    return filePaths;
  }
}

import 'package:flutter/material.dart';
import 'package:subdivide/out.dart';

const noWarn = out;

class Triangle extends StatelessWidget {
  const Triangle({
    Key? key,
    required this.offsets,
    required this.color,
  }) : super(key: key);

  final List<Offset> offsets;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        Path()..addPolygon(offsets, true),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke,
      ),
    );
  }
}

/// The painter for [Ball].
class _Painter extends CustomPainter {
  const _Painter(this.path, this.paint_, this.paintStroke_);

  final Path path;
  final Paint paint_;
  final Paint paintStroke_;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path, paint_);
    canvas.drawPath(path, paintStroke_);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => true;
}

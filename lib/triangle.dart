import 'package:flutter/material.dart';

class Triangle extends StatelessWidget {
  const Triangle({Key? key, required this.offsets, required this.color})
      : super(key: key);

  final List<Offset> offsets;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _Painter(
            Path()..addPolygon(offsets, true),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill));
  }
}

/// The painter for [Ball].
class _Painter extends CustomPainter {
  const _Painter(this.path, this.paint_);

  final Path path;
  final Paint paint_;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path, paint_);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => false;
}

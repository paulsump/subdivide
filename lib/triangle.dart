import 'package:flutter/material.dart';

class Triangle extends StatelessWidget {
  const Triangle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(painter: _Painter());
  }
}

const offsets = [Offset(0, 0), Offset(1, 0), Offset(0, 1)];

/// The painter for [Ball].
class _Painter extends CustomPainter {
  const _Painter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()..addPolygon(offsets, true),
        Paint()
          ..color = Colors.purple
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => false;
}

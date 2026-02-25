import 'package:flutter/material.dart';

class CarIllustration extends StatelessWidget {
  const CarIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 140,
      child: CustomPaint(
        painter: CarPainter(),
      ),
    );
  }
}

class CarPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = const Color(0xFF3B82F6)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 10;

    _drawClouds(canvas, size);
    _drawCar(canvas, cx, cy);
    _drawSpeedLines(canvas, cx, cy);
  }

  void _drawClouds(Canvas canvas, Size size) {
    _drawCloud(canvas, size.width * 0.18, 18, 22);
    _drawCloud(canvas, size.width * 0.75, 12, 18);
  }

  void _drawCloud(Canvas canvas, double x, double y, double scale) {
    final path = Path();

    path.addOval(Rect.fromCenter(
        center: Offset(x, y + scale * 0.3),
        width: scale * 1.4,
        height: scale * 0.8));

    path.addOval(Rect.fromCenter(
        center: Offset(x + scale * 0.5, y),
        width: scale,
        height: scale * 0.8));

    path.addOval(Rect.fromCenter(
        center: Offset(x - scale * 0.4, y + scale * 0.1),
        width: scale * 0.9,
        height: scale * 0.7));

    canvas.drawPath(path, _paint);
  }

  void _drawCar(Canvas canvas, double cx, double cy) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTRB(cx - 68, cy - 5, cx + 68, cy + 18),
      const Radius.circular(6),
    );
    canvas.drawRRect(body, _paint);

    final roof = Path();
    roof.moveTo(cx - 38, cy - 5);
    roof.lineTo(cx - 25, cy - 32);
    roof.lineTo(cx + 22, cy - 32);
    roof.lineTo(cx + 38, cy - 5);
    canvas.drawPath(roof, _paint);

    final leftWindow = RRect.fromRectAndRadius(
      Rect.fromLTRB(cx - 34, cy - 29, cx - 4, cy - 7),
      const Radius.circular(3),
    );
    canvas.drawRRect(leftWindow, _paint);

    final rightWindow = RRect.fromRectAndRadius(
      Rect.fromLTRB(cx + 2, cy - 29, cx + 34, cy - 7),
      const Radius.circular(3),
    );
    canvas.drawRRect(rightWindow, _paint);

    canvas.drawCircle(Offset(cx - 40, cy + 22), 14, _paint);
    canvas.drawCircle(Offset(cx - 40, cy + 22), 5, _paint);
    canvas.drawCircle(Offset(cx + 38, cy + 22), 14, _paint);
    canvas.drawCircle(Offset(cx + 38, cy + 22), 5, _paint);
  }

  void _drawSpeedLines(Canvas canvas, double cx, double cy) {
    final linePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(cx - 55, cy + 40),
        Offset(cx - 25, cy + 40),
        linePaint);

    canvas.drawLine(
        Offset(cx + 10, cy + 40),
        Offset(cx + 50, cy + 40),
        linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
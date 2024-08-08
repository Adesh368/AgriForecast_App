import 'package:flutter/material.dart';

class GeometricTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 4)
      ..lineTo(size.width / 4, size.height * 3 / 4)
      ..lineTo(size.width * 3 / 4, size.height * 3 / 4)
      ..close();

    canvas.drawPath(path, paint);

    paint.color = Colors.red;
    canvas.drawRect(
      Rect.fromLTWH(size.width / 4, size.height / 4, size.width / 2, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GeometricTriangle extends StatelessWidget {
  const GeometricTriangle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100), // Set your desired image size here
      painter: GeometricTrianglePainter(),
    );
  }
}

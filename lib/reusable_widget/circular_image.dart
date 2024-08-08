import 'package:flutter/material.dart';

class CircularPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw concentric circles
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(center, radius - i * 15, paint..color = Colors.blue[200 * (i + 1)]!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CircularPattern extends StatelessWidget {
  const CircularPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100), // Set your desired image size here
      painter: CircularPatternPainter(),
    );
  }
}

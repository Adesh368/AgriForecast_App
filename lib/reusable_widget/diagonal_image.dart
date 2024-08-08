import 'package:flutter/material.dart';

class DiagonalStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final stripeWidth = 20.0;
    for (double i = 0; i < size.width; i += stripeWidth * 2) {
      final path = Path()
        ..moveTo(i, 0)
        ..lineTo(i + stripeWidth, size.height)
        ..lineTo(i + stripeWidth * 2, size.height)
        ..lineTo(i + stripeWidth, 0)
        ..close();
      canvas.drawPath(path, paint);
      paint.color = paint.color.withOpacity(0.8); // Alternating stripe color
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DiagonalStripe extends StatelessWidget {
  const DiagonalStripe({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100), // Set your desired image size here
      painter: DiagonalStripePainter(),
    );
  }
}

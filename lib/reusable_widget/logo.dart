import 'package:flutter/material.dart';

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 4)
      ..lineTo(size.width / 4, size.height * 3 / 4)
      ..lineTo(size.width * 3 / 4, size.height * 3 / 4)
      ..close();

    canvas.drawPath(path, paint);

    paint.color = Colors.yellow;
    canvas.drawCircle(Offset(size.width / 2, size.height / 4), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Logo extends StatelessWidget {
  const Logo({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100), // Set your desired logo size here
      painter: LogoPainter(),
    );
  }
}

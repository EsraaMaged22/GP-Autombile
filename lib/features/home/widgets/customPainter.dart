import 'package:flutter/material.dart';
import 'dart:math';

// --- CUSTOM PAINTER FOR THE ARC
class GradientArcPainter extends CustomPainter {
  final double startAngle; // in radians
  final double sweepAngle; // in radians
  final double strokeWidth;
  final List<Color> gradientColors;

  GradientArcPainter({
    required this.startAngle,
    required this.sweepAngle,
    this.strokeWidth = 8,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: gradientColors,
        stops: [0.0, 0.6, 1.0], // tweak as needed
        center: Alignment.center,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2 - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// --- REUSABLE WIDGET (WITH IMAGE OR ICON)
class GradientArcInfo extends StatelessWidget {
  final Widget centerWidget; // This can be Icon, Image, etc.
  final String value;
  final TextStyle? valueStyle;
  final double startAngle; // in radians
  final double sweepAngle; // in radians
  final double size;
  final List<Color>? gradientColors;

  const GradientArcInfo({
    Key? key,
    required this.centerWidget,
    required this.value,
    this.valueStyle,
    required this.startAngle,
    required this.sweepAngle,
    this.size = 90,
    this.gradientColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradient = gradientColors ??
        [
          Colors.blue.withOpacity(0.0),
          Colors.blue,
          Colors.blue.withOpacity(0.0),
        ];
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: GradientArcPainter(
              startAngle: startAngle,
              sweepAngle: sweepAngle,
              gradientColors: gradient,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              centerWidget,
              SizedBox(height: 4),
              Text(value, style: valueStyle ?? TextStyle(fontSize: size * 0.26, color: Colors.grey[700])),
            ],
          ),
        ],
      ),
    );
  }
}

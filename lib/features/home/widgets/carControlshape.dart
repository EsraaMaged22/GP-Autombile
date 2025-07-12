import 'package:flutter/material.dart';

class InvertedWaveHeader extends StatelessWidget {
  final double height;
  final Color color;
  const InvertedWaveHeader({this.height = 140, this.color = const Color(0xFFF2F2F5), super.key});
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: InvertedTopWaveClipper(),
      child: Container(
        color: color,
        height: height,
      ),
    );
  }
}

class InvertedTopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);

    path.quadraticBezierTo(
      size.width * 0.25, 40,
      size.width * 0.5, 40,
    );

    path.quadraticBezierTo(
      size.width * 0.75, 40,
      size.width, 0,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(this.text, {required this.gradient, required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class GradientBorderBox extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double borderWidth;
  final Gradient borderGradient;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const GradientBorderBox({
    super.key,
    required this.child,
    required this.borderGradient,
    this.borderRadius = 20,
    this.borderWidth = 2,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient border layer
        Container(
          decoration: BoxDecoration(
            gradient: borderGradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          // Make the border appear all around
        ),
        // Solid background layer, inset to show the border
        Positioned.fill(
          child: Container(
            margin: EdgeInsets.all(borderWidth),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius - borderWidth),
            ),
            padding: padding,
            child: child,
          ),
        ),
      ],
    );
  }
}
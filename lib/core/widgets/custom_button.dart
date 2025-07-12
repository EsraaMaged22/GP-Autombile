import 'package:flutter/material.dart';

import '../constants/colors.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 53,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF196bbe),
                AppColor.primaryBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: child ??
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xffF9F9F9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}


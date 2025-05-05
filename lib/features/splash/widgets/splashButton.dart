import 'package:autombile/features/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';

class SplashButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xffb3b3b3),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [

          Positioned(
            left: 16,
            child: GestureDetector(   onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Onboarding()),
              );
            },
              child: Container(
                width: 140,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ Color(0xFF196bbe),
                      AppColor.primaryBlue]
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.arOneSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Positioned(
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_forward_ios, color: Color(0xff8c8e9d), size: 20),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, color: Color(0xff72758d), size: 20),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, color: Color(0xFF4d5078), size: 20),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, color: Color(0xFF323769),  size: 20),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, color: AppColor.primaryBlue, size: 20),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
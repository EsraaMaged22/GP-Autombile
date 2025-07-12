import 'package:autombile/core/constants/colors.dart';
import 'package:autombile/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

import '../auth/login/login.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {

      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Onboarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: Column(
        children: [
          SizedBox(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          ClipPath(
            clipper: TopCurveClipper(),
            child: Container(
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                color: AppColor.primaryBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class TopCurveClipper extends CustomClipper<Path> {
@override
Path getClip(Size size) {
Path path = Path();
// Start at top left, 40px down
path.moveTo(0, 40);
// Curve to top center (dip down), then up to right 40px down
path.quadraticBezierTo(
size.width / 2, 0, // control point
size.width, 40     // end point
);
path.lineTo(size.width, size.height); // down right side
path.lineTo(0, size.height);          // left along bottom
path.close();                         // back to start
return path;
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
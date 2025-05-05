
import 'package:autombile/features/splash/widgets/splashButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';
import 'dart:async';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool showNewImage = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showNewImage = true;
      });
      Future.delayed(Duration(milliseconds: 400), () {
        setState(() {
          showText = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                radius: 1,
                center: Alignment.centerRight,
                colors: [
                  AppColor.primaryBlue,
                  Color(0xff101012),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Align(
              alignment: Alignment.centerRight,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  opacity: showNewImage ?0.9:1.0,
                  duration: Duration(milliseconds: 400),
                  child: showNewImage
                      ? Image.asset("assets/images/carpart2.png", height: 330, key: ValueKey(2))
                      : Image.asset("assets/images/carpart1.png", height: 330, key: ValueKey(1)),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: showText ? 1.0 : 0.0,
            child:  Padding(
              padding: const EdgeInsets.only(left: 20,top: 40),
              child: Align( alignment: Alignment.topLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Let’s\n",
                      style: GoogleFonts.montserrat(
                        color: Color(0xffd4d8ff),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        decorationColor: Colors.blue,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text: "Guardian On\n",
                      style: GoogleFonts.montserrat(
                        color: Color(0xff8892ff),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        decorationThickness: 3,
                      ),
                    ),
                    TextSpan(
                      text: "Your Go",
                      style: GoogleFonts.montserrat(
                        color: Color(0xff8892ff),
                        fontSize: 36,
                        decorationColor: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decorationThickness: 3,
                      ),
                    ),
                  ],
                ),
              ),
                        ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SplashButton(),
          ),
        ],
      ),
    );
  }
}

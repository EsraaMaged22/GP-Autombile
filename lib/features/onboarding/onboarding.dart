import 'package:autombile/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';

class Onboarding extends StatefulWidget {
   const Onboarding({super.key});


  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List <Introduction> list = [
    Introduction(imageUrl: 'assets/images/cardriving1.png', title: 'MONITOR',titleTextStyle: AppFonts.headlineBlue, subTitleTextStyle: GoogleFonts.aldrich(fontSize: 20,color: Color(0xff4b4b4b)),subTitle:'Real-time monitoring of your driving speed and behavior, identifying potential risks.'),
    Introduction(imageUrl: 'assets/images/cardriving2.png', title: 'ALERT', titleTextStyle: AppFonts.headlineBlue,subTitleTextStyle: GoogleFonts.aldrich(fontSize: 20,color: Color(0xff4b4b4b)),subTitle:'Be notified instantly about distractions, fatigue, dangerous driving conditions or potential hazards.'),
    Introduction(imageUrl: 'assets/images/cardriving3.png', title: 'PROTECT', titleTextStyle: AppFonts.headlineBlue,subTitleTextStyle:GoogleFonts.aldrich(fontSize: 20,color: Color(0xff4b4b4b)) ,subTitle: 'Let’s safeguard yourself with a new level of driving safety with our comprehensive protection system.')
  ];
  @override

  Widget build(BuildContext context) {
    return IntroScreenOnboarding(  backgroudColor: Color(0xfff9f9f9),
    introductionList: list,
    skipTextStyle: TextStyle(color: Colors.grey),
    );
  }
}

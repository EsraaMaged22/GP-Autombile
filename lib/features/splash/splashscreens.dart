// import 'package:autombile/features/onboarding/widgets/splashButton.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../core/constants/colors.dart';
//
// // class Onboarding1 extends StatefulWidget {
// //   const Onboarding1({super.key});
// //
// //   @override
// //
// //   State<Onboarding1> createState() => _Onboarding1State();
// // }
// //
// // class _Onboarding1State extends State<Onboarding1> {
// //   @override
// //
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //           children: [Container( width: double.infinity,height: double.infinity,
// //             decoration: const BoxDecoration(
// //                 gradient: RadialGradient( radius: 1,center: Alignment.centerRight,
// //                     colors:[
// //                       AppColor.primaryBlue,
// //                       Color(0xff101012),
// //                     ] )
// //             ),
// //           ),
// //             Align( alignment: Alignment.centerRight,
// //                 child: Image.asset("assets/images/carpart1.png",height: 330,)),
// //
// //             Align(alignment: Alignment.bottomCenter,
// //                 child: OnBoardingButton()
// //             )
// //           ]
// //       ),
// //
// //
// //     );
// //   }
// // }
//
//
//
// class Onboarding2 extends StatefulWidget {
//   const Onboarding2({super.key});
//
//   @override
//   State<Onboarding2> createState() => _Onboarding2State();
// }
//
// class _Onboarding2State extends State<Onboarding2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//           children: [Container( width: double.infinity,height: double.infinity,
//             decoration: const BoxDecoration(
//                 gradient: RadialGradient( radius: 1,center: Alignment.centerRight,
//                     colors:[
//                       AppColor.primaryBlue,
//                       Color(0xff101012),
//                     ] )
//             ),
//           ),
//             Align( alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 90),
//                   child: Image.asset("assets/images/carpart2.png",height: 330,),
//                 )),
//
//             Align(alignment: Alignment.bottomCenter,
//                 child: OnBoardingButton()
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top:80,left: 20),
//               child: Align( alignment: Alignment.topLeft,
//                 child: RichText(
//                   textAlign: TextAlign.left,
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "Let’s\n",
//                         style: GoogleFonts.montserrat(
//                           color: Color(0xffd4d8ff),
//                           fontSize: 36,
//                           fontWeight: FontWeight.bold,
//                           decorationColor: Colors.blue,
//                           decorationThickness: 3,
//                         ),
//                       ),
//                       TextSpan(
//                         text: "Guardian On\n",
//                         style: GoogleFonts.montserrat(
//                           color: Color(0xff8892ff),
//                           fontSize: 36,
//                           fontWeight: FontWeight.bold,
//                           decorationThickness: 3,
//                         ),
//                       ),
//                        TextSpan(
//                         text: "Your Go",
//                         style: GoogleFonts.montserrat(
//                           color: Color(0xff8892ff),
//                           fontSize: 36,
//                           decorationColor: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                           decorationThickness: 3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ]
//       ),
//
//
//     );
//   }
// }

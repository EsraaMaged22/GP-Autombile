import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppFonts {
   static var headlineText= const TextStyle(fontFamily: 'Sakana',color: Colors.black,fontWeight:FontWeight.w400,fontSize: 24 );
   static var headlineBlue= const TextStyle(fontFamily: 'Sakana',color: AppColor.primaryBlue,fontWeight:FontWeight.w400,fontSize: 36 );
   static var textStyle16gray= GoogleFonts.arOneSans(fontSize: 16,fontWeight: FontWeight.w500,color: AppColor.grey);
   static var textStyle16white= GoogleFonts.cairo(fontSize: 16,fontWeight: FontWeight.w600,color: const Color(0xffF9F9F9));
   static var textStyle14gray= GoogleFonts.arOneSans(fontSize: 14,fontWeight: FontWeight.w500,color: AppColor.grey);
   static var textStyle20black=  GoogleFonts.nunitoSans( fontSize: 20,fontWeight: FontWeight.w500,color: Color(0xff242424));
}

import 'package:autombile/features/auth/signup/verify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/custom_button.dart';
import '../api_service.dart';

class Otp extends StatefulWidget {
  final String email;
  const Otp({super.key, required this.email});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(color: AppColor.primaryBlue, fontSize: 24),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.primaryBlue),
      ),
    );

    return Scaffold(
      backgroundColor: AppColor.backGround,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 204, height: 70),
Padding(
  padding: const EdgeInsets.only(top: 30),
  child: Text('OTP VERIFICATION',style: AppFonts.headlineText,),
),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15),
              child: Text(
                'Please enter the 5-digit code we sent to your email',
                style: AppFonts.textStyle16gray,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 30, bottom: 30),
              child: Text(
                widget.email,
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primaryBlue,
                ),
              ),
            ),
            Center(
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                length: 5,
                onCompleted: (value) {
                  otpCode = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: CustomButton(
                text: 'Verify',
                onPressed: () async {
                  try {
                    final response = await ApiService().generateOtp(
                      email: widget.email,
                      otp: otpCode,
                    );
                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyAccount(),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text('Resend again?', style: AppFonts.textStyle16gray),
                  Text('Request new code in ...', style: AppFonts.textStyle14gray),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

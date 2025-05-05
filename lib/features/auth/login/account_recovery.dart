import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/custom_button.dart';
import 'login.dart';
import 'new_password.dart';

class AccountRecovery extends StatefulWidget {
  final String email;
  const AccountRecovery({super.key, required this.email});

  @override
  State<AccountRecovery> createState() => _AccountRecoveryState();
}

class _AccountRecoveryState extends State<AccountRecovery> {
  @override
  Widget build(BuildContext context) {

    final defaultPinTheme=PinTheme(width: 50,height: 50 ,
        textStyle: TextStyle(color: AppColor.primaryBlue ,fontSize: 24),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2),borderRadius: BorderRadius.circular(8),border: Border.all(color: AppColor.primaryBlue),
        ));
    return Scaffold(
      backgroundColor: AppColor.backGround ,
      body: SafeArea(child: Column( crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Image.asset("assets/images/logo.png", width: 204, height: 70),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text('account recovery code',style: AppFonts.headlineText,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text('Please enter the 5-digit code , we sent to your email ',style: AppFonts.textStyle16gray,),
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
            child: Container(
              child: Pinput(defaultPinTheme: defaultPinTheme,length: 5,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 20),
            child: CustomButton(text: ' Create new password', onPressed: ()
            { Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewPassword()));

            } ),
          ),

          Center(
            child: Column(
              children: [
                Text('Resend again? ',style: AppFonts.textStyle16gray,),
                Text('Request new code in ... ',style: AppFonts.textStyle14gray,),
              ],
            ),
          ),

        ],)),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/custom_button.dart';
import 'account_recovery.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGround ,
      body: SafeArea(child: Column( crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:80),
            child: Image.asset("assets/images/logo.png", width: 204, height: 70),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text('Create new password',style: AppFonts.headlineText,),
          ),

          Padding(
            padding: const EdgeInsets.only(top:30,bottom: 20,left: 10,right: 10),
            child: const CustomTextFormField(
              hintText: "  Password",
              icon: Icons.lock,
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: const CustomTextFormField(
              hintText: " Confirm Password",
              icon: Icons.lock,
              obscureText: true,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: CustomButton(text: 'Confirm', onPressed: ()
            {
            } ),
          )

        ],)),
    );
  }
}
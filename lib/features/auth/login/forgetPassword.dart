import 'package:autombile/features/auth/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/custom_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late var rememberPassword = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
        padding: const EdgeInsets.only(top: 40),
            child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [ Image.asset("assets/images/logo.png",width: 204,height: 70,),
                Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Forget Password',style: AppFonts.headlineText,),
              ),
              Text('Please enter your email!',style: AppFonts.textStyle16gray,),
              Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: CustomTextFormField(hintText: "Enter your Email",validator: (value) {
              if (value!.isEmpty) {
              return 'Enter your email';
              }
              return null;
              },
              ),
              ),
                CustomButton(
                      text: "Send verification code",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
                        } else {
              print('Form is invalid');
                        }
                      },
                ),
                Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Resend again?',style: AppFonts.textStyle16gray,),
                )
              ]),
            ),
            ),
            ),
    );
  }
}

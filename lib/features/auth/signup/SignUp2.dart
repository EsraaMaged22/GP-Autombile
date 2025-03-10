import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/custom_button.dart';
import '../../home/home.dart';
import '../login/login.dart';

class Signup2 extends StatefulWidget {
  const Signup2({super.key});

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  final _formKey = GlobalKey<FormState>();
  late var agreeTerm = false;
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
              children: [ Image.asset("assets/images/logo.png",width: 204,height: 70,),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Create account',style: AppFonts.headlineText,),
                ),
                Text('Welcome,Wishing you a nice trip',style: AppFonts.textStyle16gray,),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomTextFormField(hintText: "National ID",validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter National ID';
                    }
                    else if (value.length != 14) {
                      return 'National ID must be 14 digits';}
                    return null;
                  },),
                ),
                CustomTextFormField(hintText: "Address",validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your address';
                  }
                  return null;
                },),
                CustomTextFormField(hintText: "License number",validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your license number';
                  }
                  return null;
                },),

                CustomTextFormField(hintText: "Number of cars you have",validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your number of cars';
                  }
                  return null;
                },),

                CustomTextFormField(hintText: "car dashboard",validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter car dashboard';
                  }
                  return null;
                },),


                Row(
                  children: [ Checkbox(
                    value: agreeTerm,
                    onChanged: (bool? value) {
                      setState(() {
                        agreeTerm = value!;
                      });
                    },
                    activeColor: AppColor.grey,
                    side: BorderSide(color: AppColor.grey),
                  ),
                    Text("I agree to the terms of use ",
                        style: GoogleFonts.workSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.grey,
                        ),

                          ),
                  ],
                ),
                CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    if (_formKey.currentState!.validate() && agreeTerm) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else if (!agreeTerm) {
                      print('You must agree to the terms of use');
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: AppColor.primaryBlue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                              print('Sign Up tapped');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
                  ),
                ),
            ),


      )
    ) ;
  }
}

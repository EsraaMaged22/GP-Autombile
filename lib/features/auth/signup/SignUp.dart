import 'package:autombile/features/auth/signup/SignUp2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/custom_button.dart';
import '../../home/home.dart';
import '../login/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
 State createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  @override
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
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomTextFormField(hintText: "Full name from national ID",validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your Full name';
                    }
                    return null;
                  },),
                ),
                CustomTextFormField(hintText: "Email",validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },),
                CustomTextFormField(hintText: "Phone Number",validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your phone number';
                  }
                  else if (value.length != 11) {
                    return 'phone number is invalid';}
                  return null;
                },),

                CustomTextFormField(
                  hintText: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  hintText: " Confirm Password",
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm your password';
                    }
                    return null;
                  },
                ),
                CustomButton(
                  text: "Next",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup2(),
                        ),
                      );
                    } else {
                      print('Form is invalid');
                    }
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

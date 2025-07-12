import 'package:autombile/features/auth/login/account_recovery.dart';
import 'package:autombile/features/auth/login/login.dart';
import 'package:autombile/features/auth/login/new_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/custom_button.dart';
import '../../services/api_service.dart';
import '../models/user_model.dart';

class ForgetPassword extends StatefulWidget {
  final String email;
  const ForgetPassword({super.key, required this.email});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late var rememberPassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Image.asset("assets/images/logo.png", width: 204, height: 70),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Forget Password', style: AppFonts.headlineText),
                ),
                Text('Please enter your email!', style: AppFonts.textStyle16gray),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: CustomTextFormField(
                    controller: emailController,
                    hintText: "Enter your Email",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                CustomButton(
                  text: "Send verification code",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final response = await ApiService().forgotPassword(
                          email: emailController.text.trim(),
                        );
                        print("Success: ${response.data['message']}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountRecovery(email: widget.email),
                          ),
                        );
                      } catch (e) {
                        print("Error: $e");
                      }
                    } else {
                      print('Form is invalid');
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Resend again?', style: AppFonts.textStyle16gray),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
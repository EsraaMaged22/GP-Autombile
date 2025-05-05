import 'package:autombile/core/constants/colors.dart';
import 'package:autombile/core/constants/fonts.dart';
import 'package:autombile/core/widgets/CustomTextField.dart';
import 'package:autombile/features/auth/signup/SignUp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_button.dart';
import '../../home/home.dart';
import '../api_service.dart';
import 'forgetPassword.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool rememberPassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  // Function to handle login
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Response response = await _apiService.login(
        emailOrId: _emailOrIdController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a success message and token
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Successful!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data["message"] ?? "Login failed!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:80),
                child: Image.asset("assets/images/logo.png", width: 204, height: 70),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Login', style: AppFonts.headlineText),
              ),
              Text('Welcome back, You\'ve been missed', style: AppFonts.textStyle16gray),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CustomTextFormField(
                  controller: _emailOrIdController,
                  hintText: "Email/ National ID",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email/ National ID';
                    }
                    return null;
                  },
                ),
              ),
              CustomTextFormField(
                controller: _passwordController,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberPassword,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberPassword = value!;
                            });
                          },
                          activeColor: AppColor.primaryBlue,
                          side: const BorderSide(color: AppColor.primaryBlue),
                        ),
                        Text('Remember me', style: AppFonts.textStyle14gray),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgetPassword(  email: _emailOrIdController.text.trim() )),
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: AppFonts.textStyle14gray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                text: "Log in",
                onPressed: _login,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: AppColor.primaryBlue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup1()),
                            );
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
    );
  }
}

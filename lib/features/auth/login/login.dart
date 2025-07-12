import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autombile/core/constants/colors.dart';
import 'package:autombile/core/constants/fonts.dart';
import 'package:autombile/core/widgets/CustomTextField.dart';
import 'package:autombile/features/auth/signup/SignUp.dart';
import '../../../core/widgets/custom_button.dart';
import '../../services/api_service.dart';
import '../cubit/login_cubit.dart';
import 'forgetPassword.dart';
import '../../home/widgets/BottomNavBar.dart';

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

  // Function to handle dialog displays and navigation
  void _onLoginSuccess() {
    _showLocationDialog(context);
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/location2.png', height: 50),
            const SizedBox(height: 16),
            const Text(
              'Allow AutoMbile to access this device\'s location?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Deny'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showDrivingModeDialog(context);
                  },
                  child: const Text('Allow'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _showDrivingModeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/lock.png', height: 50),
            const SizedBox(height: 16),
            const Text(
              'Driving mode is active now\nDistracting apps are paused',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Turn off'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    );
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(ApiService()),
      child: BlocListener<LoginCubit, bool>(
        listener: (context, isLoading) {
          if (!isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successful!")),
            );
            _onLoginSuccess();
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Image.asset("assets/images/logo.png",
                        width: 204, height: 70),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text('Login', style: AppFonts.headlineText),
                  ),
                  Text('Welcome back, You\'ve been missed',
                      style: AppFonts.textStyle16gray),
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
                              side:
                              const BorderSide(color: AppColor.primaryBlue),
                            ),
                            Text('Remember me',
                                style: AppFonts.textStyle14gray),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword(
                                        email: _emailOrIdController.text
                                            .trim())),
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
                  BlocBuilder<LoginCubit, bool>(
                    builder: (context, isLoading) {
                      return isLoading
                          ? CircularProgressIndicator()
                          : CustomButton(
                        text: "Log in",
                        onPressed: () {
                          context.read<LoginCubit>().login(
                            _emailOrIdController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 16),
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
                                  MaterialPageRoute(
                                      builder: (context) => Signup1()),
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
        ),
      ),
    );
  }
}
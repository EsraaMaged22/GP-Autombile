import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import 'signup2.dart';
import '../models/user_model.dart';

class Signup1 extends StatefulWidget {
  const Signup1({super.key});

  @override
  State<Signup1> createState() => _Signup1State();
}

class _Signup1State extends State<Signup1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset("assets/images/logo.png", width: 204, height: 70),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Create account', style: AppFonts.headlineText),
                ),
                Text('Welcome, Wishing a nice trip.', style: AppFonts.textStyle16gray),
                const SizedBox(height: 30),
                CustomTextFormField(
                  hintText: 'Full Name',
                  controller: _fullNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'Phone Number',
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length != 11 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Phone number must be exactly 11 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'National ID',
                  controller: _nationalIdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your national ID';
                    }
                    if (value.length != 14 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'National ID must be exactly 14 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup2(
                            user: UserModel(
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              phoneNumber: _phoneNumberController.text,
                              nationalId: _nationalIdController.text,
                              address: '',
                              licenseNumber: '',
                              numberOfCars: 0,
                              carDashboard: '',
                            ),
                          ),
                        ),
                      );
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
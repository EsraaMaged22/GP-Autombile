import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/custom_button.dart';
import '../models/user_model.dart';
import 'otp.dart';

class Signup2 extends StatefulWidget {
  final UserModel user;

  const Signup2({super.key, required this.user});

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _carsNumberController = TextEditingController();
  final TextEditingController _dashboardController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Create account', style: AppFonts.headlineText),
                ),
                Text('Keep going to start your trip.', style: AppFonts.textStyle16gray),
                const SizedBox(height: 30),
                CustomTextFormField(
                  hintText: 'Address',
                  controller: _addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'License Number',
                  controller: _licenseController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your license number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'Number of Cars',
                  controller: _carsNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of cars';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'Car Dashboard',
                  controller: _dashboardController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter car dashboard';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  icon: Icons.visibility,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Sign up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedUser = UserModel(
                        fullName: widget.user.fullName,
                        email: widget.user.email,
                        phoneNumber: widget.user.phoneNumber,
                        nationalId: widget.user.nationalId,
                        address: _addressController.text,
                        licenseNumber: _licenseController.text,
                        numberOfCars: int.tryParse(_carsNumberController.text) ?? 0,
                        carDashboard: _dashboardController.text,
                      );

                      // Proceed to OTP screen with updated user
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Otp(email: widget.user.email),
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
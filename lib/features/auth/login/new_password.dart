import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/CustomTextField.dart';
import '../../../core/widgets/custom_button.dart';
import '../../services/api_service.dart';
import 'login.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "The password changed\nsuccessfully",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              "You can now log in again !",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child:CustomButton(text: 'Login', onPressed: (){
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>const Login()) );
              })
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notice'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK')
          )
        ],
      ),
    );
  }

  Future<void> _resetPassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      _showDialog('Please fill all fields');
      return;
    }
    if (password != confirmPassword) {
      _showDialog('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiService = ApiService();
      final response = await apiService.resetPassword(
        password: password,
        passwordConfirmation: confirmPassword,
      );
      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        _showDialog(response.data['message'] ?? "Reset failed");
      }
    } catch (e) {
      _showDialog('Reset failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGround ,
      body: SafeArea(child: SingleChildScrollView(
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
              child: Text('Create new password',style: AppFonts.headlineText,),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
              child: CustomTextFormField(
                controller: _passwordController,
                hintText: "New Password",
                icon: Icons.lock,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: CustomTextFormField(
                controller: _confirmPasswordController,
                hintText: "Confirm Password",
                icon: Icons.lock,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
              child: CustomButton(
                text: 'Confirm',
                onPressed: () { //_resetPassword;
                 _showSuccessDialog();}
              ),
            )
          ],
        ),
      )),
    );
  }
}
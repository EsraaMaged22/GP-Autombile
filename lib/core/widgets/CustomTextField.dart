import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';


class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    this.controller,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscure,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          suffixIcon: widget.icon != null
              ? IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Color(0xff5a5a5a)
            ),
            onPressed: _toggleObscure,
          )
              : null,
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.primaryBlue, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.primaryBlue, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.primaryBlue, width: 1.5),
          ),
        ),
        style: AppFonts.textStyle16gray,
      ),
    );
  }
}




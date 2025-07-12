import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomProfileInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomProfileInput({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.enabled = true,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColor.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 18),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF293659), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF293659), width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF293659), width: 1),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
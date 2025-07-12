import 'package:flutter/material.dart';

import '../../core/widgets/custom_button.dart';
import '../services/api_service.dart';

class DrivingModeScreen extends StatefulWidget {
  const DrivingModeScreen({super.key});

  @override
  State<DrivingModeScreen> createState() => _DrivingModeScreenState();
}

class _DrivingModeScreenState extends State<DrivingModeScreen> {
  bool isLoading = false;

  Future<void> _toggleDrivingMode() async {
    setState(() { isLoading = true; });
    try {
      await ApiService().toggleDrivingMode(isEnabled: true);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Driving mode turned on!'))
      );
      // You may want to update UI or pop after success!
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e'))
      );
    } finally {
      setState(() { isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Slight rounded corners as in the screenshot
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Driving Mode', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "When you need time to focus, you can pause distracting apps and hide their notifications",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8A8A8F),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 18),
            // Your custom gradient button here!
            CustomButton(
              text: "Turn on now",
              onPressed: isLoading ? null : _toggleDrivingMode,
              child: isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
                  : const Text(
                "Turn on now",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffF9F9F9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Your distracting apps",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Select apps",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            // ... (here you would put the list/widgets for apps, not shown in screenshot)
          ],
        ),
      ),
    );
  }
}
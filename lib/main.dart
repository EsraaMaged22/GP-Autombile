import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:autombile/features/home/CarControl.dart';
import 'package:autombile/features/auth/login/login.dart';
import 'package:autombile/features/onboarding/onboarding.dart';
import 'package:autombile/features/profile/profileScreen.dart';
import 'package:autombile/features/profile/ScreenDetails.dart';
import 'package:autombile/features/profile/drivingMode.dart';
import 'package:autombile/features/home/uploadEvidence.dart';
import 'package:autombile/features/home/widgets/BottomNavBar.dart';
import 'package:autombile/features/splash/splash.dart';
import 'package:autombile/features/splash/splash2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ldeuvdhndyuvdxabxowr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxkZXV2ZGhuZHl1dmR4YWJ4b3dyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE4ODYyNTAsImV4cCI6MjA2NzQ2MjI1MH0.Ym9jKAaUMPDBh0vET0if4xT-Sy-v802LS0o6wvyViJw',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash()
    );
  }
}

import 'package:autombile/features/auth/login/forgetPassword.dart';
import 'package:autombile/features/auth/login/login.dart';
import 'package:autombile/features/home/widgets/bottomnavbar.dart';
import 'package:autombile/features/onboarding/onboarding.dart';

import 'package:flutter/material.dart';

import 'features/splash/splash.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login()
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../core/widgets/custom_button.dart';
import '../../home/home.dart';

class VerifyAccount extends StatelessWidget {
  const VerifyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColor.backGround,
      body: Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('The account has been\n confirmed successfully',style: AppFonts.textStyle20black),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('Glad to welcome you !',style: AppFonts.textStyle16gray),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomButton(text: 'Get Started', onPressed:()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> HomeScreen()));
              }),
            )],),

      ),);
  }
}
import 'dart:math';

import 'package:autombile/features/home/widgets/customPainter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color(0xfff9f9f9), appBar: AppBar(title: Row(children: [
      CircleAvatar(child: Image.asset('assets/images/avatar.png'),
    ),
      const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column( spacing: 4, crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Text('Good morning,',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),

            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Israa',style: TextStyle(fontSize: 12),),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 60),
        child:  IconButton(onPressed: (){}, icon: Image.asset('assets/icons/notification.png',width: 30,))
      )
    ],),),
    body: Column(mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
      padding: const EdgeInsets.only(left: 10,top: 30),
      child: Image.asset('assets/images/car_home.png',height: 200,width: 250,),

    ),
      ClipPath(  clipper: TopCurveClipper(),
        child: Container(
          width: double.infinity,
         height: 310,
          decoration: BoxDecoration(
            color: Color(0xffe8e8e8),
         // borderRadius:
         // const BorderRadius.vertical(
         //    top: Radius.circular(280),
         //    ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GradientArcInfo(
                      centerWidget: Image.asset(
                        'assets/icons/car.png',
                        width: 32,
                        height: 32,
                        color: Colors.grey[700],
                      ),
                      value: '5',
                      startAngle: pi * 4/ 5,
                      sweepAngle: pi * 1,
                      gradientColors: [
                        Color(0xFF313562).withOpacity(0.0),
                        Color(0xFF313562),
                        Color(0xFF313562).withOpacity(0.0),
                      ],
                    ),
                    GradientArcInfo(
                      centerWidget: Image.asset(
                        'assets/icons/navigation.png',
                        width: 32,
                        height: 32,
                        color: Colors.grey[700],
                      ),
                      value: '300km',
                      startAngle: pi * 5/ 4 ,
                      sweepAngle: pi * 1,
                      gradientColors: [
                        Colors.pinkAccent.withOpacity(0.0),
                        Colors.pinkAccent,
                        Colors.pinkAccent.withOpacity(0.0),
                      ],
                    ),
                  ],
                ),
              )
        
        
             , Row(
                children: [
        
        
        
        
        
                 Padding(
                   padding: const EdgeInsets.only(left: 30),
                   child: Container(  width:40,height: 40,decoration:  BoxDecoration(
                       color: Colors.white,
                       shape: BoxShape.circle,),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Image.asset('assets/icons/location.png'),
                       )),
                 ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '7622 Highway 9 Felton, CA',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
             Row(
            children: [
        
        
        
            Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Container(  width:40,height: 40
          ,decoration:
            const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,),
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/location.png'),
            )),
            ),
            SizedBox(width: 10),
            const Expanded(
            child: Text(
            '7622 Highway 9 Felton, CA',
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
            ),
            ),
            ],
            ),
            ],
          ),
        ),
      )

    ],));
  }
}
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(
      size.width / 2, 0,
      size.width, 80,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
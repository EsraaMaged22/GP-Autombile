import 'package:autombile/features/home/uploadEvidence.dart';
import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold( backgroundColor: Color(0xfff9f9f9),
      appBar: AppBar(title: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
      CircleAvatar(child: Image.asset('assets/images/avatar.png'),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 5),
        child: Column( spacing: 4, crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Text('Good morning,',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),

            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text('Israa',style: TextStyle(fontSize: 14),),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(children: [ Row(children: [

          Image.asset('assets/icons/location.png',width: 18),
          Text(' My Location',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
        ],),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text('Mansoura,Dakahlia',style: TextStyle(fontSize: 12), ),
          )
        ],
        ),
      ),
    ],
    ),
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, spacing: 5,
      children: [
        Center(child: Text('Emergency Call \n       needed ?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
        Center(child: Text('just hold the button',style: TextStyle(fontSize: 12,color: Colors.grey),)),
        SizedBox(height: 40,),
        SizedBox( width: 500, height: 150,
          child: GestureDetector(
            onTap: () { Navigator.push(
                context, MaterialPageRoute(builder: (context) => UploadEvidencePage(emergencyId: 1)));

            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                border: Border.all(
                  color: Colors.grey,
                  width: 7,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/emergency.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.normal,
              ),
              children: const [
                TextSpan(text: "If you press , you have "),
                TextSpan(
                  text: "24h",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: "\n   to Upload the evidence"),
              ],
            ),
          ),
        )
      ],),
    ),);
  }
}

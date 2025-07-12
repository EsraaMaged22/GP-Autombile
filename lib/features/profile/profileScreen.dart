import 'package:autombile/features/auth/models/user_model.dart';
import 'package:autombile/features/profile/ScreenDetails.dart';
import 'package:autombile/features/profile/drivingMode.dart';
import 'package:autombile/features/profile/updateProfile.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../auth/login/login.dart';
import 'CustomprofileTile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color(0xfff9f9f9),
      appBar: AppBar(title: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text('Profile'),
      IconButton(onPressed: (){}, icon: Image.asset('assets/icons/notification.png',width: 30,))],
    ),),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [CircleAvatar(child: Image.asset('assets/images/avatar.png'),radius: 30,),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Text('Israa',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Text('Doctor',style: TextStyle(fontSize: 12),)
                ],),
        
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 170),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EditProfileScreen(user:UserModel(fullName: 'israa', email: 'email', phoneNumber: '', nationalId: '', address: '', licenseNumber: '', numberOfCars: 9, carDashboard: '') )));
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                       gradient: LinearGradient(
                         colors: [
                           Color(0xFF196bbe),
                           AppColor.primaryBlue,
                         ],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       ),
        
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/edit.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
        
        
              ],
        
            ),

            CustomProfileTile(
              iconAsset: 'assets/icons/info.png',
              label: "Personal info",
              onTileTap: () {
              },
              onChevronTap: () {
              },
            ),
            CustomProfileTile(
              iconAsset: 'assets/icons/car.png',
              label: "Car Info",
              onTileTap: () {
              },
              onChevronTap: () {
              },
            ),
            CustomProfileTile(
              iconAsset: 'assets/icons/violation.png',
              label: "My violation",
              onTileTap: () {
              },
              onChevronTap: () {
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (context) => Vio()));
              },
            ),
            CustomProfileTile(
              iconAsset: 'assets/icons/driving.png',
              label: "Driving mode",
              onTileTap: () {
              },
              onChevronTap: () {
        
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DrivingModeScreen()));
              },
            ),
            CustomProfileTile(
              iconAsset: 'assets/icons/help.png',
              label: " Help & support",
              onTileTap: () {
              },
              onChevronTap: () {
              },
            ),
            CustomProfileTile(
              iconAsset: 'assets/icons/trip.png',
              label: " Latest Trip Detail",
              onTileTap: () {
              },
              onChevronTap: () {  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SessionDetailScreen()));
              },
            ),
            const SizedBox(height: 5),
        
            Container(  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical:2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ExpansionTile(
                leading: Icon(Icons.settings, color: Colors.grey[700], size: 28),
                title: Text("Settings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                children: [
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text("Privacy"),
                    onTap: () {
                      // handle
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text("Information"),
                    onTap: () {
                      // handle
                    },
                  ),
                ],
              ),
            ),
        
            Container(  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical:2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Log out", style: TextStyle(color: Colors.red)),
                onTap: () {

                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
                },
              ),
            ),
          ],
        ),
      ),
    ),
      );
  }
}

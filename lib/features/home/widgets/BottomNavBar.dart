
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:autombile/features/profile/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../CarControl.dart';
import '../Emergency.dart';
import '../homeScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Page controller
  final _pageController = PageController(initialPage: 0);

  // NotchBottomBarController
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 4;
  // Color getGradientColor() {
  //   return Color.lerp(
  //     Color(0xFF196bbe),
  //     AppColor.primaryBlue,
  //     0.5,
  //   ) ?? AppColor.primaryBlue;
  //
  // }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  final List<Widget> _screens = [
    HomeScreen(),
    CarControl(),
    Emergency(),
    ProfileScreen(),
  ];
  // Bottom nav items
  final List<BottomBarItem> bottomBarItems = [
    BottomBarItem(
      inActiveItem: Image.asset(
        'assets/icons/home.png',
        color: Colors.black,
      ),
      activeItem: Image.asset(
        'assets/icons/activeHome.png',
        color: Colors.white,
      ),
      itemLabel: 'Home',
    ),

    BottomBarItem(
      inActiveItem: Image.asset(
        'assets/icons/car.png',
        color: Colors.black,
      ),
      activeItem: Image.asset(
        'assets/icons/activeCar.png',
        color: Colors.white,
      ),
      itemLabel: 'CarControl',
    ),

    BottomBarItem(
      inActiveItem: Image.asset(
        'assets/icons/phone.png',
        color: Colors.black,
      ),
      activeItem: Image.asset(
        'assets/icons/activePhone.png',
        color: Colors.white,
      ),
      itemLabel: 'Emergency',
    ),

    BottomBarItem(
      inActiveItem: Image.asset(
        'assets/icons/person.png',
        color: Colors.black,
      ),
      activeItem: Image.asset(
        'assets/icons/activeProfile.png',
        color: Colors.white,
      ),
      itemLabel: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: true,
        notchGradient: LinearGradient(
          colors: [
          Color(0xFF196bbe),
      AppColor.primaryBlue,
      ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),

        removeMargins: false,
        bottomBarWidth: 200,
        showShadow: true,
        durationInMilliSeconds: 300,
        elevation: 1,
        bottomBarItems: bottomBarItems,

        // Handle navigation
        onTap: (index) {
          _pageController.jumpToPage(index);
        },

        // Animation properties
        kIconSize: 20.0,
        kBottomRadius: 20.0,
      ),
    );
  }
}







    // bottomNavigationBar: AnimatedNotchBottomBar(
    //
    // bottomBarItems: [
    // const BottomBarItem(
    // inActiveItem: Icon(
    // Icons.home_filled,
    // color: Colors.blueGrey,
    // ),
    // activeItem: Icon(
    // Icons.home_filled,
    // color: Colors.blueAccent,
    // ),
    // itemLabel: 'Page 1', ], notchBottomBarController: null, onTap: (int value) {  }, kIconSize: null, kBottomRadius: null,

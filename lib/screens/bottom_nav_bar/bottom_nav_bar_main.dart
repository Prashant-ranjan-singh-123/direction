import 'package:direction/screens/bottom_nav_bar/home/home_page_after_login.dart';
import 'package:direction/screens/bottom_nav_bar/profile/profile_page_after_login.dart';
import 'package:direction/screens/bottom_nav_bar/recharge/recharge_page_after_login.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/app_fonts.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBarMain extends StatefulWidget {
  const BottomNavBarMain({super.key});

  @override
  State<BottomNavBarMain> createState() => _BottomNavBarMainState();
}

class _BottomNavBarMainState extends State<BottomNavBarMain> {
  @override
  int _current_selected = 0;
  List<List<dynamic>> bottomNavBarItems = [
    [Icon(IconlyLight.home), 'Home'],
    [Icon(IconlyLight.wallet), 'Recharge'],
    [Icon(IconlyLight.profile), 'Profile'],
  ];

  List<IconData> activeIcon = [
    IconlyBold.home,
    IconlyBold.wallet,
    IconlyBold.profile
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: _body_builder(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.secondary,
        selectedLabelStyle: AppTextStyle.body2().copyWith(fontWeight: FontWeight.w900),
        unselectedLabelStyle: AppTextStyle.h4().copyWith(fontFamily: AppFonts.gilroy_light),
        selectedFontSize: 12,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
              icon: bottomNavBarItems[0][0],
              label: bottomNavBarItems[0][1],
              activeIcon: Icon(activeIcon[0], color: AppColor.secondary)),
          BottomNavigationBarItem(
            icon: bottomNavBarItems[1][0],
            label: bottomNavBarItems[1][1],
            activeIcon: Icon(activeIcon[1], color: AppColor.secondary),
          ),
          BottomNavigationBarItem(
              icon: bottomNavBarItems[2][0],
              label: bottomNavBarItems[2][1],
              activeIcon: Icon(
                activeIcon[2],
                color: AppColor.secondary,
              ),),
        ],
        onTap: (var page) {
          setState(() {
            if (page == 0) {
              _current_selected = 0;
            } else if (page == 1) {
              _current_selected = 1;
            } else {
              _current_selected = 2;
            }
          });
        },
        currentIndex: _current_selected,
      ),
    );
  }

  Widget _body_builder() {
    if (_current_selected == 0) {
      return HomePageAfterLogin();
    } else if (_current_selected == 1) {
      return RechargePageAfterLogin();
    } else {
      return ProfilePageAfterLogin();
    }
  }
}

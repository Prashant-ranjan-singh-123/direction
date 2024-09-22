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
  int current_page;
  BottomNavBarMain({super.key, this.current_page = 0});

  @override
  State<BottomNavBarMain> createState() => _BottomNavBarMainState();
}

class _BottomNavBarMainState extends State<BottomNavBarMain> {
  @override
  late int _current_selected;
  List<List<dynamic>> bottomNavBarItems = [
    [Icon(IconlyLight.home), 'Home'],
    [Icon(IconlyLight.wallet), 'Recharge'],
  ];

  List<IconData> activeIcon = [
    IconlyBold.home,
    IconlyBold.wallet,
  ];

  @override
  void initState() {
    _current_selected = widget.current_page;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _body_builder(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.secondary,
        selectedLabelStyle:
            AppTextStyle.h1(fontSize: 14).copyWith(fontWeight: FontWeight.w900),
        unselectedLabelStyle:
            AppTextStyle.h1(fontSize: 12).copyWith(fontFamily: AppFonts.gilroy_light),
        selectedFontSize: 12,
        unselectedFontSize: 10,
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
        ],
        onTap: (var page) {
          setState(() {
            if (page == 0) {
              _current_selected = 0;
            } else{
              _current_selected = 1;
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
    } else{
      return RechargePageAfterLogin();
    }
  }
}

import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_after_login.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/recharge/recharge_page_after_login.dart';
import 'package:direction/services/amplititude.dart';
import 'package:direction/utils/log_events_name.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/internet/no_internet_checker.dart';

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
    [SvgPicture.asset(AppAssets.svg_home_inactive), 'Home'],
    [SvgPicture.asset(AppAssets.svg_recharge_inactive), 'Recharge'],
  ];

  List<dynamic> activeIcon = [
    SvgPicture.asset(AppAssets.svg_home_active),
    SvgPicture.asset(AppAssets.svg_recharge_active),
  ];

  @override
  void initState() {
    _current_selected = widget.current_page;
    super.initState();
  }

  Widget build(BuildContext context) {
    return NoInternetConnectionChecker(
      child: Scaffold(
        body: _body_builder(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColor.secondary,
          selectedLabelStyle:
              AppTextStyle.body1(fontSize: 14).copyWith(fontWeight: FontWeight.w900),
          unselectedLabelStyle:
          AppTextStyle.body1(fontSize: 14).copyWith(fontWeight: FontWeight.w900),
          selectedFontSize: 12,
          unselectedFontSize: 10,
          items: [
            BottomNavigationBarItem(
                icon: bottomNavBarItems[0][0],
                label: bottomNavBarItems[0][1],
                activeIcon: activeIcon[0]),
            BottomNavigationBarItem(
              icon: bottomNavBarItems[1][0],
              label: bottomNavBarItems[1][1],
              activeIcon: activeIcon[1],
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
      ),
    );
  }

  Widget _body_builder() {
    if (_current_selected == 0) {
      MyAppAmplitudeAndFirebaseAnalitics.instanse().logEvent(event: LogEventsName.instance().click_home);
      return HomePageAfterLogin();
    } else{
      return RechargePageAfterLogin();
    }
  }
}

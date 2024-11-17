import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_after_login.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_cubit.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/recharge/recharge_page_after_login.dart';
import 'package:direction/services/amplititude.dart';
import 'package:direction/utils/log_events_name.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/internet/no_internet_checker.dart';
import 'bottom_nav_bar/profile/profile_page_after_login.dart';
import 'bottom_nav_bar_cubit.dart';

class BottomNavBarMain extends StatelessWidget {
  final int initialPage;

  const BottomNavBarMain({super.key, this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit()..updatePage(initialPage),
      child: NoInternetConnectionChecker(
        child: Scaffold(
          body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
            builder: (context, state) {
              return _buildBody(state.currentIndex);
            },
          ),
          bottomNavigationBar:
              BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
            builder: (context, state) {
              return _buildBottomNavigationBar(context, state.currentIndex);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(int currentIndex) {
    if (currentIndex == 0) {
      MyAppAmplitudeAndFirebaseAnalitics.instanse()
          .logEvent(event: LogEventsName.instance().click_home);
      return BlocProvider(
        create: (context) => HomePageCubit(),
        child: HomePageAfterLogin(),
      );
    } else if (currentIndex == 1) {
      return RechargePageAfterLogin();
    } else {
      return ProfilePageAfterLogin();
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      selectedItemColor: AppColor.secondary,
      selectedLabelStyle: AppTextStyle.body1(fontSize: 14)
          .copyWith(fontWeight: FontWeight.w900),
      unselectedLabelStyle: AppTextStyle.body1(fontSize: 14)
          .copyWith(fontWeight: FontWeight.w900),
      selectedFontSize: 12,
      unselectedFontSize: 10,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.svg_home_inactive),
            label: 'Home',
            activeIcon: SvgPicture.asset(AppAssets.svg_home_active)),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.svg_recharge_inactive),
          label: 'Recharge',
          activeIcon: SvgPicture.asset(AppAssets.svg_recharge_active),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.svg_profile_inactive),
          label: 'Profile',
          activeIcon: SvgPicture.asset(AppAssets.svg_profile_active),
        ),
      ],
      onTap: (page) {
        context.read<BottomNavBarCubit>().updatePage(page);
      },
      currentIndex:
          currentIndex, // Make sure this is reading from the updated state
    );
  }
}

import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../screens/after_login/bottom_nav_bar_cubit.dart';
import '../../screens/after_login/bottom_nav_bar_main.dart';
import '../../utils/app_asset.dart';

class FailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SvgPicture.asset(AppAssets.svg_error)),
              SizedBox(height: 20),
              Text('Purchase Failed!', style: AppTextStyle.body1(fontSize: 30)),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => BottomNavBarCubit(),
                          child: BottomNavBarMain(initialPage: 1), // Set `current_page` to 1 (Recharge tab)
                        ),
                      ), (Route<dynamic> route) => false, // This clears the navigation stack
                    );
                  },
                  child: Text(
                    'Try Again',
                    style: AppTextStyle.body1(fontColor: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';

class HomePageAfterLogin extends StatefulWidget {
  const HomePageAfterLogin({super.key});

  @override
  State<HomePageAfterLogin> createState() => _HomePageAfterLoginState();
}

class _HomePageAfterLoginState extends State<HomePageAfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Page',
          style: AppTextStyle.h1(fontSize: 20, fontColor: AppColor.secondary),
        ),
      ),
    );
  }
}

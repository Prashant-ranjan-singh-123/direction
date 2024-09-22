import 'package:direction/shared/app_bar.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomePageAfterLogin extends StatefulWidget {
  const HomePageAfterLogin({super.key});

  @override
  State<HomePageAfterLogin> createState() => _HomePageAfterLoginState();
}

class _HomePageAfterLoginState extends State<HomePageAfterLogin> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.afterLoginAppBar(title: 'Home'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(IconlyLight.home, color: AppColor.secondary, size: 50,),
            Text(
              'Home Page',
              style: AppTextStyle.h1(fontSize: 20, fontColor: AppColor.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

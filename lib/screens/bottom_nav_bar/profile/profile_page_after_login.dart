import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../utils/app_color.dart';
import '../../../utils/text_style.dart';

class ProfilePageAfterLogin extends StatefulWidget {
  const ProfilePageAfterLogin({super.key});

  @override
  State<ProfilePageAfterLogin> createState() => _ProfilePageAfterLoginState();
}

class _ProfilePageAfterLoginState extends State<ProfilePageAfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(IconlyLight.profile, color: AppColor.secondary, size: 50,),
            Text(
              'Profile Page',
              style: AppTextStyle.h1(fontSize: 20, fontColor: AppColor.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

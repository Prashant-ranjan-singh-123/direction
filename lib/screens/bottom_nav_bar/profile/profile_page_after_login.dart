import 'package:flutter/material.dart';

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
      body: Center(
        child: Text(
          'Profile Page',
          style: AppTextStyle.h1(fontSize: 20, fontColor: AppColor.secondary),
        ),
      ),
    );
  }
}

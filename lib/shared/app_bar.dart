import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';

class AppAppBar {
  static AppBar afterLoginAppBar({required String title}) {
    return AppBar(
      centerTitle: false,
      title: Text(
        title,
        style: AppTextStyle.body1(fontColor: AppColor.primary, fontSize: 18).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

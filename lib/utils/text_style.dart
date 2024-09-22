import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyle {

  static TextStyle h1({double fontSize = 20, Color fontColor = AppColor.primary}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_extra_bold);
  }

  static TextStyle body1({double fontSize = 18, Color fontColor = AppColor.tertiry}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        color: fontColor,
        fontFamily: AppFonts.gilroy_light);
  }

  static TextStyle recharge_banner({double fontSize = 14, Color fontColor = AppColor.white}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w100,
        color: fontColor,
        fontFamily: AppFonts.gilroy_extra_bold);
  }

  static TextStyle recharge_current_banner_text() {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w100,
        color: AppColor.font_black,
        fontFamily: AppFonts.gilroy_extra_bold);
  }
}

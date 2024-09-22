import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyle {

  static TextStyle h4({double fontSize = 14, Color fontColor = AppColor.primary}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_extra_bold);
  }

  static TextStyle h3({double fontSize = 16, Color fontColor = AppColor.primary}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_extra_bold);
  }

  static TextStyle h2({double fontSize = 18, Color fontColor = AppColor.primary}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_extra_bold);
  }

  static TextStyle h1({double fontSize = 20, Color fontColor = AppColor.primary}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_extra_bold);
  }




  static TextStyle body4({double fontSize = 14, Color fontColor = AppColor.tertiry}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_light);
  }

  static TextStyle body3({double fontSize = 16, Color fontColor = AppColor.tertiry}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_light);
  }

  static TextStyle body2({double fontSize = 20, Color fontColor = AppColor.tertiry}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_light);
  }

  static TextStyle body1({double fontSize = 18, Color fontColor = AppColor.tertiry}) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: AppFonts.gilroy_light);
  }
}

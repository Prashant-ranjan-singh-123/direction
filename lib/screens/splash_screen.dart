import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/app_fonts.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Spacer(),
              _logo_top(),
              const SizedBox(height: 15,),
              _text(),
              Spacer(),
              _bottom_family_image()
            ],
          ),
        ),
      )
    );
  }

  Widget _logo_top(){
    return Column(
      children: [
        SvgPicture.asset(AppAssets.svg_logo),
        const SizedBox(height: 15,),
        Builder(
          builder: (BuildContext context) {
            return SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: Divider(color: AppColor.primary.withOpacity(0.1),));
          })
      ],
    );
  }

  Widget _text(){
    return Text('Get directions for your life problems', style: AppTextStyle.h3().copyWith(fontFamily: AppFonts.gilroy_light, fontWeight: FontWeight.w500),);
  }

  Widget _bottom_family_image(){
    return Image.asset(AppAssets.png_splash_family);
  }
}

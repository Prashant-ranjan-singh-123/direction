import 'package:direction/services/other_app_opener.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:pull_down_button/pull_down_button.dart';

class AppAppBar {
  static AppBar afterLoginAppBar(
      {required String title,
      bool is_high_icon = true,
      bool isBoldHead = false,
      bool isPrivacyPolicy = false}) {
    return AppBar(
      centerTitle: false,
      title: Row(
        children: [
          if (is_high_icon)
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset(AppAssets.svg_hello),
            )
          else
            SizedBox(),
          Text(
            title,
            style: isBoldHead
                ? AppTextStyle.h1(fontColor: AppColor.primary, fontSize: 20)
                    .copyWith(fontWeight: FontWeight.w900)
                : AppTextStyle.body1(fontColor: AppColor.primary, fontSize: 20)
                    .copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
      actions: [
        isPrivacyPolicy
            ? PullDownButton(
          position: PullDownMenuPosition.over,
                itemBuilder: (context) => [
                  PullDownMenuItem(
                    icon: IconlyLight.shield_done,
                    title: 'Privacy Policy',
                    onTap: () {
                      AppOpener.launchPrivacyPolicy();
                    },
                  ),
                ],
                buttonBuilder: (context, showMenu) => CupertinoButton(
                  onPressed: showMenu,
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(AppAssets.svg_hamberger, height: 15,),
                ),
              )
            : SizedBox()
      ],
    );
  }
}

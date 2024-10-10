import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';

import '../../../../services/amplititude.dart';
import '../../../../services/other_app_opener.dart';
import '../../../../shared/app_bar.dart';
import '../../../../utils/app_asset.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/log_events_name.dart';
import '../../../../utils/text_style.dart';

class ProfilePageAfterLogin extends StatefulWidget {
  const ProfilePageAfterLogin({super.key});

  @override
  State<ProfilePageAfterLogin> createState() => _ProfilePageAfterLoginState();
}

class _ProfilePageAfterLoginState extends State<ProfilePageAfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.afterLoginAppBar(
          title: 'My Profile', isPrivacyPolicy: false, is_high_icon: false),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            _profile_photo(),
            _profile_buttons(
                logoString: AppAssets.svg_shield,
                name: 'Privacy Policy',
                fun: () {
                  AppOpener.launchPrivacyPolicy();
                }),
            _profile_buttons(
                logoString: AppAssets.svg_logout, name: 'Log Out', fun: () {}),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            _build_chat_support()
          ],
        ),
      ),
    );
  }

  Widget _build_chat_support() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You want any help?',
            style: AppTextStyle.h1(fontColor: AppColor.font_black),
          ),
          Text(
              'We’ve got you covered, Chat with us on Whatsapp right now and get helped!'),
          SizedBox(
            height: 15,
          ),
          AspectRatio(
            aspectRatio: 16 / 2,
            child: ElevatedButton(
                onPressed: () async {
                  MyAppAmplitudeAndFirebaseAnalitics.instanse()
                      .logEvent(event: LogEventsName.instance().click_help);
                  await AppOpener.launchAppUsingUrl(
                      link:
                          'https://wa.me/+917993478539?text=Hey,%20I%20downloaded%20direction%20-%20I%20am%20having%20a%20problem');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.svg_whatsapp),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chat Support',
                      style: AppTextStyle.h1(
                          fontSize: 16, fontColor: AppColor.white),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _profile_buttons(
      {required String logoString,
      required String name,
      required Function fun}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
        onPressed: () => fun(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(logoString),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                child: Text(
                  name,
                  style: AppTextStyle.body1(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget _profile_photo() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.03),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.33,
            height: MediaQuery.of(context).size.width * 0.33,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black), // Border color
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.33),
              child: Container(
                child: SvgPicture.asset(
                  AppAssets.svg_default_profile_photo,
                  fit: BoxFit
                      .contain, // Use BoxFit.cover to ensure it fills the circle
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            'Sagar Dattatrey',
            style: AppTextStyle.recharge_banner(
                    fontColor: AppColor.black, fontSize: 20)
                .copyWith(fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }
}

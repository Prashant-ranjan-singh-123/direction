import 'package:direction/services/internet/no_internet_checker.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/app_fonts.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:ip_country_lookup/models/ip_country_data_model.dart';

import '../services/amplititude.dart';
import '../services/shared_preference.dart';
import '../utils/amplititude_events_name.dart';
import 'after_login/bottom_nav_bar_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _change_page();
    country_check();
    logFirstInstallEvent();
    super.initState();
  }

  Future<void> logFirstInstallEvent() async {
    if(await SharedPreferenceLogic.isfreshInstall()) {
      print('This is first time of user');
      await MyAppAmplitude.instanse().logEvent(event: AmplititudeEventsName
          .instance()
          .install);
    }
  }


  Future<void> country_check() async {
    IpCountryData countryData = await IpCountryLookup().getIpLocationData();
    String? data = countryData.country_code;
    if (data == null) {
      print('exception');
    } else {
      await SharedPreferenceLogic.saveCountryCode(
          countryCodeString: data ?? '');
    }
  }

  void _change_page() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavBarMain()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return _portrate();
      } else {
        return _landscape();
      }
    });
  }

  Widget _portrate() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
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
                const SizedBox(
                  height: 15,
                ),
                _text(),
                Spacer(),
                _bottom_family_image()
              ],
            ),
          ),
        ));
  }

  Widget _landscape() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: SafeArea(
          bottom: false,
          right: false,
          left: false,
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    );
                  }),
                  _logo_top(),
                  const SizedBox(
                    height: 15,
                  ),
                  _text(),
                  Builder(builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    );
                  }),
                  _bottom_family_image()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _logo_top() {
    return Column(
      children: [
        SvgPicture.asset(AppAssets.svg_logo),
        const SizedBox(
          height: 15,
        ),
        Builder(builder: (BuildContext context) {
          return SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Divider(
                color: AppColor.primary.withOpacity(0.1),
              ));
        })
      ],
    );
  }

  Widget _text() {
    return Text(
      'Get directions for your life problems',
      style: AppTextStyle.h1().copyWith(
          fontFamily: AppFonts.gilroy_light, fontWeight: FontWeight.w500),
    );
  }

  Widget _bottom_family_image() {
    return Image.asset(AppAssets.png_splash_family);
  }
}

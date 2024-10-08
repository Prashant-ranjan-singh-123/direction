import 'package:direction/screens/splash_screen/splash_screen_state.dart';
import 'package:direction/services/is_user_loged_in/login_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:ip_country_lookup/models/ip_country_data_model.dart';

import '../../services/amplititude.dart';
import '../../services/is_user_loged_in/login_check_cubit.dart';
import '../../services/shared_preference.dart';
import '../../utils/log_events_name.dart';
import '../after_login/bottom_nav_bar_main.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState(loading: true));

  Future<void> logFirstInstallEvent() async {
    emit(state.copyWith(loading: false));
    if (await SharedPreferenceLogic.isfreshInstall()) {
      print('This is first time of user');
      await MyAppAmplitudeAndFirebaseAnalitics.instanse()
          .logEvent(event: LogEventsName.instance().install);
    }
  }

  Future<void> country_check() async {
    emit(state.copyWith(loading: false));
    IpCountryData countryData = await IpCountryLookup().getIpLocationData();
    String? data = countryData.country_code;
    if (data == null) {
      print('exception');
    } else {
      await SharedPreferenceLogic.saveCountryCode(
          countryCodeString: data ?? '');
    }
  }

  void change_page({required BuildContext context}) {
    emit(state.copyWith(loading: false));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              BlocProvider(create: (context) => LoginCheckCubit(), child: LoginCheckScreen(),)));

      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => BottomNavBarMain()));
    });
  }
}

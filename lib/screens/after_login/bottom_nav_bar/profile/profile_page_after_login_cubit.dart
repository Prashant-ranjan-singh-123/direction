import 'package:direction/screens/after_login/bottom_nav_bar/profile/profile_screen_after_login_state.dart';
import 'package:direction/services/app_user_data_logic.dart';
import 'package:direction/services/is_user_loged_in/login_check_cubit.dart';
import 'package:direction/services/is_user_loged_in/login_check_screen.dart';
import 'package:direction/services/other_app_opener.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services/amplititude.dart';
import '../../../../utils/log_events_name.dart';


class ProfileScreenAfterLoginCubit extends Cubit<ProfileScreenAfterLoginState>{
  ProfileScreenAfterLoginCubit() : super(ProfileScreenAfterLoginState(loading: true));

  Future<void> click_log_out({required BuildContext context}) async {
    await AppUserDataLogic.log_out();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginCheckScreen()), // Directly instantiate the screen
          (Route<dynamic> route) => false, // This removes all previous routes
    );
  }

  void click_privacy_policy(){
    AppOpener.launchPrivacyPolicy();
  }

  Future<void> click_chat_support() async {
    MyAppAmplitudeAndFirebaseAnalitics.instanse()
        .logEvent(event: LogEventsName.instance().click_help);
    await AppOpener.launchAppUsingUrl(
        link:
        'https://wa.me/+917993478539?text=Hey,%20I%20downloaded%20direction%20-%20I%20am%20having%20a%20problem');
  }

  void setData() async {
    emit(state.copyWith(loading: true));

    String? image = await AppUserDataLogic.get_image_url();
    String? Name = await AppUserDataLogic.get_name();

    if (Name != null) {
      emit(state.copyWith(loading: false, name: Name, photo: image));
    } else {
      emit(state.copyWith(loading: false, name: 'Sagar Dattatrey', photo: null));
    }
  }

}
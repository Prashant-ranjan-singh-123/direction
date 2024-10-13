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

class ProfileScreenAfterLoginCubit extends Cubit<ProfileScreenAfterLoginState> {
  ProfileScreenAfterLoginCubit()
      : super(ProfileScreenAfterLoginState(loading: true));

  Future<void> click_log_out({required BuildContext context}) async {
    confirm_logout(context: context);
  }

  void click_privacy_policy() {
    AppOpener.launchPrivacyPolicy();
  }

  Future<void> click_chat_support() async {
    MyAppAmplitudeAndFirebaseAnalitics.instanse()
        .logEvent(event: LogEventsName.instance().click_help);
    await AppOpener.launchAppUsingUrl(
        link:
            'https://wa.me/+917993478539?text=Hey,%20I%20downloaded%20direction%20-%20I%20am%20having%20a%20problem');
  }

  Future<void> setData() async {
    emit(state.copyWith(loading: true));

    final result = await Future.wait([
      AppUserDataLogic.get_image_url(),
      AppUserDataLogic.get_name(),
    ]);

    String? image = result[0];
    String? name = result[1];

    if (name != null) {
      emit(state.copyWith(loading: false, name: name, photo: image));
    } else {
      emit(
          state.copyWith(loading: false, name: 'Sagar Dattatrey', photo: null));
    }
  }

  void confirm_logout({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              style:
                  TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              style:
                  TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await AppUserDataLogic.log_out();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginCheckScreen()), // Directly instantiate the screen
                  (Route<dynamic> route) =>
                      false, // This removes all previous routes
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}

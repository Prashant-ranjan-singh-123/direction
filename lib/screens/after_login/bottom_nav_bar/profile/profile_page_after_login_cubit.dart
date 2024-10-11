import 'package:direction/screens/after_login/bottom_nav_bar/profile/profile_screen_after_login_state.dart';
import 'package:direction/services/other_app_opener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services/amplititude.dart';
import '../../../../utils/log_events_name.dart';


class ProfileScreenAfterLoginCubit extends Cubit<ProfileScreenAfterLoginState>{
  ProfileScreenAfterLoginCubit() : super(ProfileScreenAfterLoginState());

  void click_log_out(){

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
}
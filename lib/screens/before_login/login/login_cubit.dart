import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_cubit.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/profile/profile_page_after_login_cubit.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/recharge/recharge_page_after_login.dart';
import 'package:direction/screens/after_login/bottom_nav_bar_cubit.dart';
import 'package:direction/screens/after_login/bottom_nav_bar_main.dart';
import 'package:direction/screens/before_login/login/login_state.dart';
import 'package:direction/services/app_user_data_logic.dart';
import 'package:direction/services/other_app_opener.dart';
import 'package:direction/utils/log_events_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../services/amplititude.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(false));

  Future<void> continue_with_google({required BuildContext context}) async {
    emit(state.copyWith(loading: true));
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(state.copyWith(loading: false));
        // The user canceled the sign-in
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Print user details
      String? email = userCredential.user?.email;
      String? image_url = userCredential.user?.photoURL.toString();
      String name = userCredential.additionalUserInfo?.profile!['name'];
      String? uuid = userCredential.user?.uid;

      await AppUserDataLogic.sign_in(
          name: name,
          uuid: uuid ?? '',
          image_url: image_url ?? '',
          email: email ?? '');
      emit(state.copyWith(loading: false));

      MyAppAmplitudeAndFirebaseAnalitics.instanse()
          .logEvent(event: LogEventsName.instance().login_sucess_google);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => BottomNavBarCubit(),
                  ),
                  BlocProvider(
                    create: (context) => HomePageCubit(),
                  ),
                  BlocProvider(
                    create: (context) => ProfileScreenAfterLoginCubit(),
                  ),
                ],
                child: BottomNavBarMain(),
              )));
    } catch (error) {
      emit(state.copyWith(loading: false));
      print(error);
    }
  }

  Future<void> open_terms_and_condition() async {
    await AppOpener.launchPrivacyPolicy();
  }
}

import 'package:direction/screens/before_login/login/login_state.dart';
import 'package:direction/services/other_app_opener.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(): super(LoginState());

  Future<void> continue_with_google() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }

  Future<void> open_terms_and_condition() async {
    await AppOpener.launchPrivacyPolicy();
  }
}
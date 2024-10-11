import 'package:direction/services/is_user_loged_in/login_check_state.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCheckCubit extends Cubit<LoginCheckState>{
  LoginCheckCubit(): super(LoginCheckState());

  Future<void> checkToken() async {
    try {
      // await SharedPreferenceLogic.setLoginFalse();
      bool isLogin = await SharedPreferenceLogic.isLogIn();
      if(isLogin){
        emit(state.copyWith(loading: false,  isTokenPresent: true));
      }else{
        emit(state.copyWith(loading: false, isTokenPresent: false));
      }
    } catch (e){
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
import 'package:direction/services/is_user_loged_in/login_check_state.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCheckCubit extends Cubit<LoginCheckState>{
  LoginCheckCubit(): super(LoadingState());

  Future<void> checkToken() async {
    try {
      emit(LoginCheckState());
      bool isLogin = await SharedPreferenceLogic.isLogIn();
      if(isLogin){
        emit(TokenFoundState());
      }else{
        emit(TokenFoundState());
      }
    } catch (e){
      emit(ErrorState(error: e.toString()));
    }
  }
}
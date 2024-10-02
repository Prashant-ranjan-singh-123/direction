import 'package:direction/screens/before_login/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(): super(InitialState(isInvalidMobileNumber: false));

  Future<void> loginButtonNumber({required String phoneNumber}) async {
    bool _is_otp_send = false;
    emit(InitialState(isInvalidMobileNumber: false));


  }
}
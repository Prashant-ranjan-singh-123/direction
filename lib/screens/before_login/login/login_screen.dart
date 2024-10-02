import 'package:direction/screens/before_login/login/login_cubit.dart';
import 'package:direction/screens/before_login/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state){
        if(state is InitialState){
          return _login_screen(isCorrectMobileNumber: state.isInvalidMobileNumber);
        }else if(state is OtpState){
          return _otp_screen();
        }else{
          return SizedBox();
        }
      }),
    );
  }

  Widget _login_screen({required bool isCorrectMobileNumber}){
    return SizedBox();
  }

  Widget _otp_screen(){
    return SizedBox();
  }
}

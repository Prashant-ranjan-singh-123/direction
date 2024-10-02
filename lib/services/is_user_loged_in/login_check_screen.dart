import 'package:direction/services/is_user_loged_in/login_check_cubit.dart';
import 'package:direction/services/is_user_loged_in/login_check_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/after_login/bottom_nav_bar_main.dart';
import '../../screens/before_login/login/login_screen.dart';
import '../../utils/app_color.dart';

class LoginCheckScreen extends StatelessWidget {
  const LoginCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCheckCubit, LoginCheckState>(
          builder: (context, state) {
        if (state is LoadingState) {
          return _loadingState();
        } else if (state is TokenFoundState) {
          return _token_not_found();
        } else if (state is TokenFoundState) {
          return _token_found();
        } else if (state is ErrorState) {
          return _error_page(errorMessage: state.error);
        } else {
          return _error_page();
        }
      }),
    );
  }

  Widget _loadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColor.secondary,
      ),
    );
  }

  Widget _error_page({String errorMessage = ''}) {
    return Center(
      child: Text('Error Occur: ${errorMessage}'),
    );
  }

  Widget _token_found() {
    return BottomNavBarMain();
  }

  Widget _token_not_found() {
    return LoginScreen();
  }
}

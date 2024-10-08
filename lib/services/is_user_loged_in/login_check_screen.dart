import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_after_login.dart';
import 'package:direction/screens/after_login/bottom_nav_bar_cubit.dart';
import 'package:direction/services/is_user_loged_in/login_check_cubit.dart';
import 'package:direction/services/is_user_loged_in/login_check_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/after_login/bottom_nav_bar/home/home_page_cubit.dart';
import '../../screens/after_login/bottom_nav_bar_main.dart';
import '../../screens/before_login/login/login_screen.dart';
import '../../utils/app_color.dart';

class LoginCheckScreen extends StatefulWidget {
  const LoginCheckScreen({super.key});

  @override
  State<LoginCheckScreen> createState() => _LoginCheckScreenState();
}

class _LoginCheckScreenState extends State<LoginCheckScreen> {
  @override
  void initState() {
    context.read<LoginCheckCubit>().checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTokenPresent = context
        .select((LoginCheckCubit cubit) => cubit.state.isTokenPresent ?? false);
    final error = context.select((LoginCheckCubit cubit) => cubit.state.error);
    final loading =
        context.select((LoginCheckCubit cubit) => cubit.state.loading);

    return Scaffold(body: BlocBuilder<LoginCheckCubit, LoginCheckState>(
        builder: (context, LoginCheckState) {
      return _build_ui(state: LoginCheckState);
    }));
  }

  Widget _build_ui({required LoginCheckState state}) {
    if (state.loading) {
      return _loadingState();
    } else if (state.error!=null) {
      return _error_page(errorMessage: state.error!);
    } else if (state.isTokenPresent==true) {
      return _token_found();
    } else {
      return _token_not_found();
    }
  }

  Widget _loadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColor.secondary,
      ),
    );
  }

  Widget _error_page({required String errorMessage}) {
    return Center(
      child: Text('Error Occur: ${errorMessage}'),
    );
  }

  Widget _token_found() {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider<BottomNavBarCubit>(
            create: (BuildContext context) => BottomNavBarCubit(),
            child: BottomNavBarMain(initialPage: 0,),
          ),
        ),
      );
    });
    return _loadingState();
  }

  Widget _token_not_found() {
    return LoginScreen();
  }
}

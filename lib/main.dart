import 'package:direction/screens/before_login/login/login_cubit.dart';
import 'package:direction/screens/splash_screen.dart';
import 'package:direction/services/is_user_loged_in/login_check_cubit.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:direction/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  runApp(AppStarter());
}

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<LoginCheckCubit>(
            create: (BuildContext context) => LoginCheckCubit(),
        )
      ],
      child: MaterialApp(
        home: SplashScreen(),
        theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            scaffoldBackgroundColor: AppColor.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: AppColor.white,
            ),
            appBarTheme: AppBarTheme(
                color: AppColor.white,
                foregroundColor: AppColor.black,
                elevation: 10,
                surfaceTintColor: Colors.transparent)),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

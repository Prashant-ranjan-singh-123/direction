import 'package:direction/screens/before_login/login/login_cubit.dart';
import 'package:direction/services/is_user_loged_in/login_check_cubit.dart';
import 'package:direction/services/my_app_firebase_analytics/AnalyticsEngine.dart';
import 'package:direction/services/prashant_app_open_permission/prashant_app_open__permission_screen.dart';
import 'package:direction/services/prashant_app_open_permission/prashant_app_open_permission_cubit.dart';
import 'package:direction/utils/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'firebase_options.dart';
import 'screens/after_login/bottom_nav_bar/profile/profile_page_after_login_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AnalyticsEngine.instance;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ZIMKit().init(

    appID: 385565720, // your appid
    appSign: '99db2a4115fc9f34062ddefafe15abab0ffb272fea768e6248ad2b926f09a630', // your appSign
  );
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
        ),
        BlocProvider<ProfileScreenAfterLoginCubit>(
            create: (context) => ProfileScreenAfterLoginCubit())
      ],
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => PrashantAppOpenPermissionCubit(),
          child: PrashantAppOpenPermission(),
        ),
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

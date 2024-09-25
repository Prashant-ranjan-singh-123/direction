import 'package:direction/screens/splash_screen.dart';
import 'package:direction/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(const AppStarter());
}

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
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
              surfaceTintColor: Colors.transparent
          )
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

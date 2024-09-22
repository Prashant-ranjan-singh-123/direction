import 'package:direction/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const AppStarter());
}

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

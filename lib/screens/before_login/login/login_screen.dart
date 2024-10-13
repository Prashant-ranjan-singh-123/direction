import 'dart:io';

import 'package:direction/screens/before_login/login/login_cubit.dart';
import 'package:direction/screens/before_login/login/login_state.dart';
import 'package:direction/services/other_app_opener.dart';
import 'package:direction/shared/circular_progress_indicator.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (BuildContext context, state) {
          if (state.loading) {
            return Stack(
              children: [
                _design_2(context: context),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: AdaptiveCircularProgressIndicator(
                              ProgressIndicatorColor: Colors.white),
                    ))
              ],
            );
          } else {
            return _design_2(context: context);
          }
        },
      ),
    );
  }

  Widget _logo() {
    return SvgPicture.asset(AppAssets.svg_logo);
  }

  Widget _create_account_text() {
    return Column(
      children: [
        Text(
          'Create your account to',
          style: AppTextStyle.body1(),
        ),
        Text('save your process', style: AppTextStyle.body1())
      ],
    );
  }

  Widget _create_account_text_design_2() {
    return Column(
      children: [
        // Text('Direction',
        //     style: AppTextStyle.body1(fontColor: AppColor.primary, fontSize: 30)),
        Text('Create your account to',
            style: AppTextStyle.body1(fontColor: Colors.black, fontSize: 25)),
        Text('Save your progress',
            style: AppTextStyle.body1(fontColor: Colors.black, fontSize: 25)),
      ],
    );
  }

  Widget _logo_design_2(double screenWidth) {
    return SizedBox(
        width: screenWidth * 0.2, child: Image.asset(AppAssets.png_only_logo));
  }

  Widget _otp_screen() {
    return SizedBox();
  }

  Widget _design_2({required BuildContext context}) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.4,
              color: AppColor.primary,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight / 6),
              child: Column(
                children: [
                  Card(
                      elevation: 10,
                      shadowColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: _logo(),
                      )),
                  // Text(
                  //           "INSUGO",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: screenWidth/8,
                  //           ),
                  //         ),
                  //         Text(
                  //           "Digi",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: screenWidth / 30,
                  //           ),
                  //         ),
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: circle(5, screenHeight, screenWidth),
          // ),
          // Transform.translate(
          //   offset: const Offset(30, -30),
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: circle(4.5, screenHeight, screenWidth),
          //   ),
          // ),
          // Center(
          //   child: circle(3, screenHeight, screenWidth),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.6,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              // color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    // _logo_design_2(screenWidth),
                    Spacer(),
                    _create_account_text_design_2(),
                    Spacer(),
                    // Spacer(),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          context
                              .read<LoginCubit>()
                              .continue_with_google(context: context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.svg_google,
                                height: 24,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'CONTINUE WITH GOOGLE',
                                style:
                                    AppTextStyle.body1(fontColor: Colors.black),
                              )
                            ],
                          ),
                        )),
                    Spacer(),
                    Spacer(),
                    SafeArea(
                      bottom: true,
                      top: false,
                      right: false,
                      left: false,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By signing in, you agree to our ',
                              style: AppTextStyle.body1(
                                  fontColor: Colors.black, fontSize: 12),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontFamily: AppFonts.gilroy_light,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the tap event here
                                  context
                                      .read<LoginCubit>()
                                      .open_terms_and_condition();
                                  // Navigate to the terms and conditions page
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget circle(double size, double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight / size,
      width: screenWidth / size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

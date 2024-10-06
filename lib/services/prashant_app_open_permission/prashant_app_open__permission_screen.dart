import 'package:direction/screens/splash_screen/splash_screen.dart';
import 'package:direction/screens/splash_screen/splash_screen_cubit.dart';
import 'package:direction/services/prashant_app_open_permission/prashant_app_open__permission_state.dart';
import 'package:direction/services/prashant_app_open_permission/prashant_app_open_permission_cubit.dart';
import 'package:direction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_asset.dart';
import '../../utils/app_fonts.dart';
import '../../utils/text_style.dart';

class PrashantAppOpenPermission extends StatefulWidget {
  const PrashantAppOpenPermission({super.key});

  @override
  State<PrashantAppOpenPermission> createState() =>
      _PrashantAppOpenPermissionState();
}

class _PrashantAppOpenPermissionState extends State<PrashantAppOpenPermission> {
  @override
  void initState() {
    super.initState();
    // Trigger the initial authentication check
    context.read<PrashantAppOpenPermissionCubit>().prashantAuth();
  }

  @override
  Widget build(BuildContext context) {
    final canLoad = context.select(
      (PrashantAppOpenPermissionCubit cubit) => cubit.state.canLoad,
    );
    final loadingState = context.select(
      (PrashantAppOpenPermissionCubit cubit) => cubit.state.loadingState,
    );

    return Scaffold(
      body: _buildUI(
          isLoading: loadingState == APILoadingState.loading, canLoad: canLoad),
    );
  }

  Widget _buildUI({required bool isLoading, required int canLoad}) {
    if (isLoading || canLoad == 0) {
      return SplashScreenHere(context: context);
    } else if (canLoad == 1) {
      return BlocProvider(
        create: (context) => SplashScreenCubit(),
        child: SplashScreen(),
      );
    } else {
      // In case of canLoad == 2, return a placeholder or another screen
      return _error_screen();
    }
  }

  Widget _insisibleText() {
    // final visibility = context.select(
    //       (PrashantAppOpenPermissionCubit cubit) => cubit.state.visibility,
    // );

    return Visibility(visible: false, child: Text('Data hidden'));
  }

  Widget SplashScreenHere({required BuildContext context}) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return _portrate();
      } else {
        return _landscape();
      }
    });
  }

  Widget _portrate() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: SafeArea(
          bottom: false,
          right: false,
          left: false,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Spacer(),
                _logo_top(),
                const SizedBox(
                  height: 15,
                ),
                _text(),
                Spacer(),
                _bottom_family_image(),
                _insisibleText()
              ],
            ),
          ),
        ));
  }

  Widget _landscape() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: SafeArea(
          bottom: false,
          right: false,
          left: false,
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    );
                  }),
                  _logo_top(),
                  const SizedBox(
                    height: 15,
                  ),
                  _text(),
                  Builder(builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    );
                  }),
                  _bottom_family_image()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _logo_top() {
    return Column(
      children: [
        SvgPicture.asset(AppAssets.svg_logo),
        const SizedBox(
          height: 15,
        ),
        Builder(builder: (BuildContext context) {
          return SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Divider(
                color: AppColor.primary.withOpacity(0.1),
              ));
        })
      ],
    );
  }

  Widget _text() {
    return Text(
      'Get directions for your life problems',
      style: AppTextStyle.h1().copyWith(
          fontFamily: AppFonts.gilroy_light, fontWeight: FontWeight.w500),
    );
  }

  Widget _bottom_family_image() {
    return Image.asset(AppAssets.png_splash_family);
  }

  Widget _error_screen() {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Lottie.asset(AppAssets.lottie_construction)],
        ),
      ),
    );
  }
}

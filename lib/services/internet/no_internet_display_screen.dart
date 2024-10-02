import 'package:direction/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_color.dart';

class NoInternetDisplayScreen extends StatelessWidget {
  const NoInternetDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColor.white,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Lottie.asset(AppAssets.lottie_no_internet)),
              Image.asset(AppAssets.png_no_internet)
            ],
          ),
        ),
    );
  }
}

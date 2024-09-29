import 'package:direction/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/circular_progress_indicator.dart';

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: SvgPicture.asset(AppAssets.svg_loading)),
              AdaptiveCircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Processing your purchase...', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

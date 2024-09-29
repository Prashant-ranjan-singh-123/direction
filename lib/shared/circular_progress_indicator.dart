import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utils/app_color.dart';

class AdaptiveCircularProgressIndicator extends StatelessWidget {
  Color ProgressIndicatorColor;

  AdaptiveCircularProgressIndicator({this.ProgressIndicatorColor = AppColor.secondary});

  @override
  Widget build(BuildContext context) {
    // Check platform and return the appropriate progress indicator
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoActivityIndicator(color: ProgressIndicatorColor,) // iOS style indicator
        : CircularProgressIndicator(color: ProgressIndicatorColor,);  // Android style indicator
  }
}

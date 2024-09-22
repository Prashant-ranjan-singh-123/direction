import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/text_style.dart';

class RechargePageAfterLogin extends StatefulWidget {
  const RechargePageAfterLogin({super.key});

  @override
  State<RechargePageAfterLogin> createState() => _RechargePageAfterLoginState();
}

class _RechargePageAfterLoginState extends State<RechargePageAfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Recharge Page',
          style: AppTextStyle.h1(fontSize: 20, fontColor: AppColor.secondary),
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../services/amplititude.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/log_events_name.dart';
import '../../../../../utils/text_style.dart';
import '../../../bottom_nav_bar_cubit.dart';
import '../../../bottom_nav_bar_main.dart';

class Dialogboxhome extends StatelessWidget {
  const Dialogboxhome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add some padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppAssets.svg_wallet_2),
          const SizedBox(height: 8), // Add some space between elements
          const Text(
            'Please recharge the wallet!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF27272A),
              fontSize: 16,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4), // Add some space between elements
          const Text(
            'To call or chat with the Counsellors, you need to recharge your account with some balance.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF52525B),
              fontSize: 12,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 20,),

          AspectRatio(
            aspectRatio: 16 / 2,
            child: ElevatedButton(
                onPressed: () async {
                  MyAppAmplitudeAndFirebaseAnalitics.instanse()
                      .logEvent(event: LogEventsName.instance().click_call_now_recharge_alert);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
                        create: (context) => BottomNavBarCubit(),
                        child: BottomNavBarMain(initialPage: 1),
                      ),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  'Recharge Now',
                  style: AppTextStyle.h1(
                      fontSize: 16, fontColor: AppColor.white),
                )),
          )
        ],
      ),
    );
  }
}

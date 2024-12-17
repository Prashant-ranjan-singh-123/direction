import 'package:direction/screens/after_login/bottom_nav_bar/home/chat_screen/chat_cubit.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/home/chat_screen/chat_screen.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_state.dart';
import 'package:direction/screens/after_login/bottom_nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../../services/amplititude.dart';
import '../../../../services/shared_preference.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/log_events_name.dart';
import '../../bottom_nav_bar_main.dart';
import 'dialog_box/DialogBoxHome.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(HomePageState(totalBalance: 0, isLoading: true, isIndia: false));

  Future<void> setData() async {
    emit(state.copyWith(isLoading: true));

    int _totalBalance;
    if ('IN' == await SharedPreferenceLogic.getCountryCode()) {
      // await SharedPreferenceLogic.saveCounter(counter: 20);
      _totalBalance = await SharedPreferenceLogic.getCounter(isIn: true);
      emit(state.copyWith(isIndia: true, totalBalance: _totalBalance));
    } else {
      _totalBalance = await SharedPreferenceLogic.getCounter(isIn: false);
      emit(state.copyWith(isIndia: false, totalBalance: _totalBalance));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> chat_now(
      {required BuildContext context,
      required int total_balance,
      required String userId,
      required String UserName,
      required String image}) async {
    // TODO (make field for click chat now)
    // Log Analytics {ignore it for now}
    MyAppAmplitudeAndFirebaseAnalitics.instanse()
        .logEvent(event: LogEventsName.instance().click_call_now);

    if (total_balance <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 10),
            backgroundColor: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(22.0), // Adjust the radius as needed
            ),
            content: const Dialogboxhome(),
          );
        },
      );
    } else {
      try {
        // await ZIMKit().connectUser(id: 'prashant@gmail.com', name: 'Prashant');
        // // ZIMKit().(context);h
        // if(ZIMKitCore.instance.isInited) {
        //   print('ZIMKitCore.instance.isInited is Inited');
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) {
        //         return ZIMKitMessageListPage(
        //           conversationID: userId,
        //           conversationType: ZIMConversationType.room,
        //         );
        //       },
        //     ),
        //   );
        // }else{
        //   print('ZIMKitCore.instance.isInited is not Inited');
        // }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ChatCubit(),
                  child: ChatScreen(
                    astrologer_name: UserName,
                    image: image,
                  ),
                )));
      } catch (e) {}
    }
  }

  void call_now({required BuildContext context, required int total_balance}) {
    MyAppAmplitudeAndFirebaseAnalitics.instanse()
        .logEvent(event: LogEventsName.instance().click_call_now);

    if (total_balance <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 10),
            backgroundColor: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(22.0), // Adjust the radius as needed
            ),
            content: const Dialogboxhome(),
          );
        },
      );
    } else {}
  }

  void recharge_now({required BuildContext context}) {
    MyAppAmplitudeAndFirebaseAnalitics.instanse()
        .logEvent(event: LogEventsName.instance().click_recharge_home_screen);
    print('its my page');
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
  }
}

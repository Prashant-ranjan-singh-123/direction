import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/shared_preference.dart';

class HomePageCubit extends Cubit<HomePageState>{
  HomePageCubit():super (HomePageState(totalBalance: 0, isLoading: true, isIndia: false));

  Future<void> setData() async {
    emit(state.copyWith(isLoading: true));
    bool _isIndia;
    int _totalBalance;
    if ('IN' == await SharedPreferenceLogic.getCountryCode()) {
      _isIndia = true;
      _totalBalance = await SharedPreferenceLogic.getCounter(isIn: true);
    } else {
      _isIndia = false;
      _totalBalance = await SharedPreferenceLogic.getCounter(isIn: false);
    }
    // _isIndia=false;
    emit(state.copyWith(isLoading: false, isIndia: _isIndia, totalBalance: _totalBalance));
  }
}
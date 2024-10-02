import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:ip_country_lookup/models/ip_country_data_model.dart';

import '../shared_preference.dart';
import 'no_internet_display_screen.dart';

class NoInternetConnectionChecker extends StatefulWidget {
  Widget child;
  NoInternetConnectionChecker({super.key, required this.child});

  @override
  State<NoInternetConnectionChecker> createState() =>
      _NoInternetConnectionCheckerState();
}

class _NoInternetConnectionCheckerState
    extends State<NoInternetConnectionChecker> {
  bool isConnectedToInternet = true;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) async {
          switch(event){
            case InternetStatus.connected:
              await _country_check();
              setState(() {
                isConnectedToInternet = true ;
              });
              break;
            case InternetStatus.disconnected:
              setState(() {
                isConnectedToInternet = false;
              });
              break;
            default:
              setState(() {
                isConnectedToInternet = false;
              });
          }
        });
  }

  Future<void> _country_check() async {
    IpCountryData countryData = await IpCountryLookup().getIpLocationData();
    String? data = countryData.country_code;
    if(data==null){
      print('exception');
    }else {
      await SharedPreferenceLogic.saveCountryCode(countryCodeString: data ?? '');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _internetConnectionStreamSubscription?. cancel();
  }
  @override
  Widget build(BuildContext context) {
    return isConnectedToInternet? widget.child : const NoInternetDisplayScreen();
  }
}

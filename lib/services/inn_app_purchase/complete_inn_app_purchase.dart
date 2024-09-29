import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../screens/bottom_nav_bar/bottom_nav_bar_main.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/text_style.dart';
import '../shared_preference.dart';

class CompleteScreen extends StatefulWidget {
  int? amount_to_save;

  CompleteScreen({required this.amount_to_save});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {

  @override
  void initState() {
    _save_value();
    super.initState();
  }

  Future<void> _save_value() async {
    if(widget.amount_to_save != null) {
      int counter = await SharedPreferenceLogic.getCounter();
      int final_value = counter+ widget.amount_to_save!;
      await SharedPreferenceLogic.saveCounter(counter: final_value);
    }
  }

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
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SvgPicture.asset(AppAssets.svg_success)),
              SizedBox(height: 20),
              Text('Purchase Success!', style: AppTextStyle.body1(fontSize: 30)),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => BottomNavBarMain(
                                  current_page: 1,
                                )),
                        (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Continue To App',
                    style: AppTextStyle.body1(fontColor: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

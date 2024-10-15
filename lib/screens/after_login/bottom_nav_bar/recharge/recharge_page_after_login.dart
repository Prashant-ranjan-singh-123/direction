import 'package:auto_size_text/auto_size_text.dart';
import 'package:direction/services/amplititude.dart';
import 'package:direction/services/inn_app_purchase/complete_inn_app_purchase.dart';
import 'package:direction/services/inn_app_purchase/fail_inn_app_purchase.dart';
import 'package:direction/services/other_app_opener.dart';
import 'package:direction/services/razorpay.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:direction/shared/app_bar.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../services/inn_app_purchase/inn_app_purchase.dart';
import '../../../../services/internet/no_internet_checker.dart';
import '../../../../utils/log_events_name.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/text_style.dart';
import '../../bottom_nav_bar_main.dart';

class RechargePageAfterLogin extends StatefulWidget {
  const RechargePageAfterLogin({super.key});

  @override
  State<RechargePageAfterLogin> createState() => _RechargePageAfterLoginState();
}

class _RechargePageAfterLoginState extends State<RechargePageAfterLogin> {
  late Razorpay _razorpay;
  bool _loading = true;
  int _total_balance = 0;
  int? _pay_transiction;
  late bool _is_india;
  late TextEditingController _amount;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = true;
    });
    _amount = TextEditingController();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _set_current_balance();
  }

  Future<void> _set_current_balance() async {

    if ('IN' == await SharedPreferenceLogic.getCountryCode()) {
      _is_india = true;
    } else {
      _is_india = false;
    }

    // _is_india = false;

    if(_is_india){
      _total_balance = await SharedPreferenceLogic.getCounter(isIn: true);
    }else{
      _total_balance = await SharedPreferenceLogic.getCounter(isIn: false);
    }
    print("Current balance set to: $_total_balance");
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _amount.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.afterLoginAppBar(
          title: 'Recharge Now', isPrivacyPolicy: true),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColor.secondary,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _top_banner(),
                  _your_current_balance(),
                  _recharge_with_following_plan(),
                  _build_chat_support()
                ],
              ),
            ),
    );
  }

  Widget _top_banner() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColor.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
            child: Text(
          'Mercy from Tampa has just recharged with \₹50',
          style: AppTextStyle.body1(fontSize: 15, fontColor: AppColor.white),
        )),
      ),
    );
  }

  Widget _your_current_balance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Your Current Balance is:',
            style: AppTextStyle.recharge_banner(
                    fontColor: AppColor.black, fontSize: 18)
                .copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 15,
          ),
          AspectRatio(
            aspectRatio: 16 / 3,
            child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    backgroundColor: AppColor.secondary_light,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    side: BorderSide(color: AppColor.secondary)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.svg_wallet),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      _is_india? '₹ ${_total_balance}': '\$ ${_total_balance}',
                      style: AppTextStyle.h1(
                          fontSize: 20, fontColor: AppColor.black),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: AppColor.font_black.withOpacity(0.1),
          )
        ],
      ),
    );
  }

  Widget _recharge_with_following_plan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 15),
          Text(
            'Recharge Immediately with following plans:',
            style: AppTextStyle.recharge_current_banner_text(),
          ),
          SizedBox(
            height: 15,
          ),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            childAspectRatio: 16 / 12,
            mainAxisSpacing: 15,
            shrinkWrap: true, // Allows GridView to be smaller
            physics: NeverScrollableScrollPhysics(),
            children:
                List.generate(6, (index) => _buildRechargeButton(index: index)),
          ),
          SizedBox(height: 15),
          Visibility(
            visible: _is_india,
            child: Column(
              children: [
                Text(
                  'Or',
                  style: AppTextStyle.recharge_current_banner_text(),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _amount,
                              decoration: InputDecoration(
                                // prefixIcon: , // Leading icon
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white), // Border when focused
                                ),
                                // hintText: 'Enter any amount', // Placeholder text
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Enter any amount',
                                        style: AppTextStyle.body1(
                                            fontSize: 12, fontColor: AppColor.black),
                                        overflow: TextOverflow
                                            .ellipsis, // This adds the ellipsis
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        ' (Min: \$10)',
                                        style: AppTextStyle.body1(
                                            fontSize: 12,
                                            fontColor:
                                            AppColor.black.withOpacity(0.4)),
                                        overflow: TextOverflow
                                            .ellipsis, // This adds the ellipsis
                                      ),
                                    ),
                                  ],
                                ), // hintText: 'Ex: 52'
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.secondary,
                              elevation: 0,
                              shadowColor: AppColor.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              MyAppAmplitudeAndFirebaseAnalitics.instanse().logEvent(event: LogEventsName.instance().click_recharge_custom);
                              // Check if the amount is a valid positive integer
                              if (_amount.text.isNotEmpty &&
                                  int.tryParse(_amount.text) != null &&
                                  int.parse(_amount.text) > 0) {
                                try {
                                  int amount = int.parse(_amount.text);
                                  _payment(money: amount);
                                } catch (e) {
                                  print('Invalid amount: ${e.toString()}');
                                }
                              } else {
                                // Optionally, you could show an error message here
                                print('Please enter a valid amount greater than 0');
                              }

                              _amount.clear();
                            },
                            child: Text(
                              'Recharge',
                              style: AppTextStyle.body1(
                                  fontColor: AppColor.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: AppColor.font_black.withOpacity(0.1),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRechargeButton({required int index}) {
    int value;
    String productId;
    String discount = '10% Extra Talktime';

    switch (index) {
      case 0:
        if (_is_india) {
          value = 100;
          productId = 'recharge_100';
        } else {
          value = 10;
          productId = 'recharge_100';
        }
        break;
      case 1:
        if (_is_india) {
          value = 150;
          productId = 'recharge_150';
        } else {
          value = 15;
          productId = 'recharge_150';
        }
        break;
      case 2:
        if (_is_india) {
          value = 200;
          productId = 'recharge_200';
        } else {
          value = 20;
          productId = 'recharge_200';
        }
        break;
      case 3:
        if (_is_india) {
          value = 250;
          productId = 'recharge_250';
        } else {
          value = 30;
          productId = 'recharge_250';
        }
        break;
      case 4:
        if (_is_india) {
          value = 500;
          productId = 'recharge_500';
        } else {
          value = 50;
          productId = 'recharge_500';
        }
        break;
      case 5:
        if (_is_india) {
          value = 800;
          productId = 'recharge_800';
        } else {
          value = 100;
          productId = 'recharge_800';
        }
        break;
      default:
        if (_is_india) {
          value = 100;
          productId = 'recharge_100';
        } else {
          value = 10;
          productId = 'recharge_100';
        }
        break;
    }

    return InkWell(
      onTap: () {
        MyAppAmplitudeAndFirebaseAnalitics.instanse().logEvent(event: LogEventsName.instance().click_recharge_pricing_button);
        if(_is_india) {
          _payment(money: value);
        }else{
          InAppPurchaseHandler(context: context).makePurchase(productId, value);
        }
      },
      splashColor:
          AppColor.secondary.withOpacity(0.5), // Color of the ripple effect
      borderRadius: BorderRadius.circular(8), // Match the card's border radius
      child: Card(
        color: AppColor.white, // Card background color
        elevation: 1, // Elevation for shadow effect
        shadowColor: AppColor.black.withOpacity(1), // Shadow color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: double.infinity, // Make the card full width
          padding: EdgeInsets.zero, // Keep internal padding zero
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _is_india? '₹ ${value}':'\$ ${value}',
                    style: AppTextStyle.h1(
                        fontSize: 18, fontColor: AppColor.black),
                  ),
                ],
              ),
              if (index > 2)
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                  child: AutoSizeText(
                    discount,
                    maxLines: 1,
                    minFontSize: 1,
                    style: AppTextStyle.h1(fontColor: AppColor.secondary),
                  ),
                )
              else
                SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _build_chat_support() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You want any help?',
            style: AppTextStyle.h1(fontColor: AppColor.font_black),
          ),
          Text(
              'We’ve got you covered, Chat with us on Whatsapp right now and get helped!'),
          SizedBox(
            height: 15,
          ),
          AspectRatio(
            aspectRatio: 16 / 2,
            child: ElevatedButton(
                onPressed: () async {
                  MyAppAmplitudeAndFirebaseAnalitics.instanse().logEvent(event: LogEventsName.instance().click_help);
                  await AppOpener.launchAppUsingUrl(
                      link:
                          'https://wa.me/+917993478539?text=Hey,%20I%20downloaded%20direction%20-%20I%20am%20having%20a%20problem');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.svg_whatsapp),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chat Support',
                      style: AppTextStyle.h1(
                          fontSize: 16, fontColor: AppColor.white),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  void _payment({required int money}) {
    var options = {
      'key': 'rzp_live_d5McFTkC2w2nZd',
      'amount': money * 100,
      'currency': 'INR', // Specify the currency
      'name': 'Direction',
      'description': 'Recharge Plan Activation',
      // 'prefill': {
      //   'contact': '+917993478539',
      //   'email': 'aarihantaaryan@gmail.com'
      // }
    };
    _pay_transiction = money;
    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (_pay_transiction != null) {
      // Update the user's balance in shared preferences
      int value;
      if(_is_india){
        value = await SharedPreferenceLogic.getCounter(isIn: true);
      }else{
        value = await SharedPreferenceLogic.getCounter(isIn: false);
      }
      int total = _pay_transiction! + value;
      await SharedPreferenceLogic.saveCounter(counter: total);
      // Refresh the current balance
      await _set_current_balance();
      // Reset the transaction amount
      _pay_transiction = 0;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CompleteScreen(
                amount_to_save: null,
              )));
      print("Payment successful: ${response.paymentId}");
    } else {
      print("Transaction amount is not set.");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FailScreen()));
    print("Payment error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment here
    print("External wallet: ${response.walletName}");
  }
}

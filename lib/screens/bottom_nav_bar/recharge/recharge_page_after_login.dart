import 'package:auto_size_text/auto_size_text.dart';
import 'package:direction/services/other_app_opener.dart';
import 'package:direction/services/razorpay.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:direction/shared/app_bar.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../utils/app_color.dart';
import '../../../utils/text_style.dart';
import '../bottom_nav_bar_main.dart';

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
  late TextEditingController _amount;

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _set_current_balance();
  }

  Future<void> _set_current_balance() async {
    setState(() {
      _loading = true;
    });
    _total_balance = await SharedPreferenceLogic.getCounter();
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
      appBar: AppAppBar.afterLoginAppBar(title: 'Recharge'),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColor.secondary,
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _top_banner(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _your_current_balance(),
                          _recharge_with_following_plan(),
                          _build_chat_support()
                        ],
                      ),
                    ),
                  ),
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
          style: AppTextStyle.recharge_banner(),
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
                .copyWith(fontWeight: FontWeight.w100),
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
                      '₹ ${_total_balance}',
                      style: AppTextStyle.recharge_current_banner_text(),
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
          Text(
            'Or',
            style: AppTextStyle.recharge_current_banner_text(),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
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
                          borderSide:
                              BorderSide(color: AppColor.secondary_light),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.secondary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Border when focused
                        ),
                        // hintText: 'Enter any amount', // Placeholder text
                        label: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SvgPicture.asset(AppAssets.svg_wallet),
                            ),
                            Text('Enter any amount')
                          ],
                        ),
                        hintText: 'Ex: 52'),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondary_light,
                      shape: RoundedRectangleBorder()),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    try {
                      int amount = int.parse(_amount.text);
                      _payment(money: amount);
                    } catch (e) {
                      print('Invalid amount: ${e.toString()}');
                    }
                    _amount.clear();
                  },
                  child: Text(
                    'Recharge',
                    style: AppTextStyle.recharge_current_banner_text(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: AppColor.font_black.withOpacity(0.1),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildRechargeButton({required int index}) {
    int value;
    String discount = '10% Extra Talktime';

    switch (index) {
      case 0:
        value = 10;
        break;
      case 1:
        value = 15;
        break;
      case 2:
        value = 20;
        break;
      case 3:
        value = 30;
        break;
      case 4:
        value = 50;
        break;
      case 5:
        value = 100;
        break;
      default:
        value = 100;
        break;
    }

    return InkWell(
      onTap: () {
        _payment(money: value);
      },
      splashColor:
          AppColor.secondary.withOpacity(0.5), // Color of the ripple effect
      borderRadius: BorderRadius.circular(8), // Match the card's border radius
      child: Card(
        color: AppColor.white, // Card background color
        elevation: 2, // Elevation for shadow effect
        shadowColor: AppColor.secondary, // Shadow color
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
                    '₹ ${value}',
                    style: AppTextStyle.recharge_current_banner_text(),
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
                  await AppOpener.launchAppUsingUrl(
                      link:
                          'https://wa.me/+917993478539?text=Hello%20i%20am%20Direction%20support%20team,%20i%20was%20getting%20some%20issue%20regarding');
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
                      style: AppTextStyle.recharge_banner(fontSize: 16),
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
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': money * 100,
      'currency': 'INR', // Specify the currency
      'name': 'Direction',
      'description': 'Recharge Plan Activation',
      'prefill': {
        'contact': '+917993478539',
        'email': 'aarihantaaryan@gmail.com'
      }
    };
    _pay_transiction = money;
    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (_pay_transiction != null) {
      // Update the user's balance in shared preferences
      int value = await SharedPreferenceLogic.getCounter();
      int total = _pay_transiction! + value;
      await SharedPreferenceLogic.saveCounter(counter: total);
      // Refresh the current balance
      await _set_current_balance();
      // Reset the transaction amount
      _pay_transiction = 0;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavBarMain(
                current_page: 1,
              )));
      // Log the payment success
      print("Payment successful: ${response.paymentId}");
    } else {
      print("Transaction amount is not set.");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error here
    print("Payment error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment here
    print("External wallet: ${response.walletName}");
  }
}

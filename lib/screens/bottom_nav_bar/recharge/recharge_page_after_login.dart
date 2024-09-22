import 'package:auto_size_text/auto_size_text.dart';
import 'package:direction/shared/app_bar.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';

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
      appBar: AppAppBar.afterLoginAppBar(title: 'Recharge'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _top_banner(),
              _your_current_balance(),
              _recharge_with_following_plan()
            ],
          ),
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
          'Mercy from Tampa has just recharged with \$50',
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
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
                      '\$ 90',
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
          SizedBox(height: 15,),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            childAspectRatio: 16/12,
            mainAxisSpacing: 15,
            shrinkWrap: true, // Allows GridView to be smaller
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(6, (index) => _buildRechargeButton(index: index)),
          ),
          SizedBox(height: 15),
          Text(
            'Or',
            style: AppTextStyle.recharge_current_banner_text(),
          ),
          SizedBox(height: 15,),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(AppAssets.svg_wallet),
                  ), // Leading icon
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.secondary_light),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.secondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Border when focused
                  ),
                  // hintText: 'Enter any amount', // Placeholder text
                  labelText: 'Enter any amount'
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder()
              ),
              onPressed: () {
                // Handle recharge action
              },
              child: Text('Recharge'),
            ),
          ),
        ],
      )
        ],
      ),
    );
  }

  Widget _buildRechargeButton({required int index}) {
    int value;
    String discount='10% Extra Talktime';

    switch (index){
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
        // Handle tap
      },
      splashColor: AppColor.secondary.withOpacity(0.5), // Color of the ripple effect
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
                    '\$ ${value}',
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

}

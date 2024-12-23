import 'package:auto_size_text/auto_size_text.dart';
import 'package:direction/model/astrologer_model.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_cubit.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/home/home_page_state.dart';
import 'package:direction/screens/after_login/bottom_nav_bar_cubit.dart';
import 'package:direction/screens/before_login/login/login_cubit.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:direction/shared/app_bar.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';

import '../../../../services/amplititude.dart';
import '../../../../services/internet/no_internet_checker.dart';
import '../../../../utils/log_events_name.dart';
import '../../bottom_nav_bar_main.dart';
import 'dialog_box/DialogBoxHome.dart';

class HomePageAfterLogin extends StatefulWidget {
  const HomePageAfterLogin({super.key});

  @override
  State<HomePageAfterLogin> createState() => _HomePageAfterLoginState();
}

class _HomePageAfterLoginState extends State<HomePageAfterLogin> {
  late int _totalBalance;
  late bool _isIndia;

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppBar.afterLoginAppBar(title: 'Hello', is_high_icon: true),
        body: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            bool loading = state.isLoading;
            _isIndia = state.isIndia;
            print('is India: ${_isIndia}');
            _totalBalance = state.totalBalance;
            return loading ? _loading() : _buildUi();
          },
        ));
  }

  Widget _buildUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topBalanceShow(balance: _totalBalance),
        _buildCard(),
      ],
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColor.secondary,
      ),
    );
  }

  Widget _topBalanceShow({required int balance}) {
    print(_isIndia);
    return Column(
      children: [
        Divider(
          color: AppColor.font_black.withOpacity(0.1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svg_wallet),
                SizedBox(width: 15),
                Text(
                  _isIndia ? '₹ ${balance}' : '\$ ${balance}',
                  style: AppTextStyle.h1(),
                ),
                Spacer(),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondary,
                      elevation: 0,
                      shadowColor: AppColor.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<HomePageCubit>()
                          .recharge_now(context: context);
                    },
                    child: Text(
                      'Recharge Now',
                      style: AppTextStyle.body1(
                          fontColor: AppColor.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: AppColor.font_black.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildCard() {
    AstrologerModel model = AstrologerModel();

    return Expanded(
      child: ListView.builder(
        itemCount: model.data.length,
        itemBuilder: (context, index) {
          var data = model.data[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.black.withOpacity(0.3), blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center vertically
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.35, // Set a fixed width for the image
                                height: 170, // Set a fixed height for the image
                                child: data.imageUrl.isNotEmpty
                                    ? Image.asset(
                                        data.imageUrl,
                                        fit: BoxFit
                                            .cover, // Ensures the image covers the box
                                      )
                                    : Container(
                                        color: AppColor
                                            .black, // Placeholder if no image
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10), // Space between image and text
                        Expanded(
                          flex:
                              2, // Flex to allow the text section to take more space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                data.name,
                                maxLines: 1,
                                minFontSize: 4,
                                style: AppTextStyle.body1(
                                    fontColor: AppColor.black),
                              ),
                              SizedBox(height: 5), // Space between name and fee
                              Card(
                                color: AppColor.secondary_light_green,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 18),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AutoSizeText(
                                        _isIndia ? '₹' : '\$',
                                        minFontSize: 4,
                                        maxLines: 1,
                                        style: AppTextStyle.h1(fontSize: 14),
                                        overflow: TextOverflow
                                            .ellipsis, // This will add an ellipsis if the text overflows
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            _isIndia
                                                ? data.highFee
                                                : data.highfeeUsa,
                                            style:
                                                AppTextStyle.h1(fontSize: 14),
                                          ),
                                          Positioned(
                                            top: 10,
                                            child: Container(
                                              width: data.highFee.length *
                                                  18, // Adjust line width based on text length
                                              height: 1, // Line thickness
                                              color: Colors.black, // Line color
                                            ),
                                          ),
                                        ],
                                      ),
                                      AutoSizeText(
                                        _isIndia
                                            ? ' ${data.fee}'
                                            : ' ${data.feeUsa}',
                                        minFontSize: 4,
                                        maxLines: 1,
                                        style: AppTextStyle.h1(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 5), // Space between fee and expertise
                              AutoSizeText(
                                'Expertise: ${data.expertise}',
                                maxLines: 1,
                                minFontSize: 4,
                                style: AppTextStyle.body1(
                                    fontColor: AppColor.black, fontSize: 12),
                              ),
                              SizedBox(height: 5), // Space before helped count
                              Container(
                                width: double.infinity,
                                color: AppColor.black.withOpacity(0.1),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          AppAssets.svg_user_group),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: AutoSizeText(
                                          '${data.helped} People Helped',
                                          maxLines: 1,
                                          minFontSize: 4,
                                          style: AppTextStyle.body1(
                                              fontColor: AppColor.black
                                                  .withOpacity(0.5),
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          // backgroundColor: AppColor.secondary,
                                          side: BorderSide(
                                              color: AppColor.secondary),
                                          foregroundColor: AppColor.primary,
                                          elevation: 0,
                                          shadowColor: AppColor.primary,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: AppColor.primary),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                        onPressed: () {
                                          context
                                              .read<HomePageCubit>()
                                              .call_now(
                                                  context: context,
                                                  total_balance: _totalBalance);
                                          // Handle recharge logic
                                        },
                                        child: AutoSizeText(
                                          'Call',
                                          maxLines: 2,
                                          minFontSize: 6,
                                          style: AppTextStyle.body1(
                                              fontColor: AppColor.secondary,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.secondary,
                                          elevation: 0,
                                          shadowColor: AppColor.secondary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        ),
                                        onPressed: () {
                                          context
                                              .read<HomePageCubit>()
                                              .chat_now(
                                                  context: context,
                                                  total_balance: _totalBalance,
                                                  userId: data.userId,
                                                  UserName: data.name,
                                                  image: data.imageUrl,
                                          );
                                          // Handle recharge logic
                                        },
                                        child: AutoSizeText(
                                          'Chat',
                                          maxLines: 2,
                                          minFontSize: 6,
                                          style: AppTextStyle.body1(
                                              fontColor: AppColor.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:direction/model/astrologer_model.dart';
import 'package:direction/services/shared_preference.dart';
import 'package:direction/shared/app_bar.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:direction/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';

class HomePageAfterLogin extends StatefulWidget {
  const HomePageAfterLogin({super.key});

  @override
  State<HomePageAfterLogin> createState() => _HomePageAfterLoginState();
}

class _HomePageAfterLoginState extends State<HomePageAfterLogin> {
  late int _totalBalance;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    setState(() {
      _isLoading = true;
    });
    _totalBalance = await SharedPreferenceLogic.getCounter();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.afterLoginAppBar(title: 'Hello Sagar!', is_high_icon: true),
      body: _isLoading ? _loading() : _buildUi(),
    );
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
                  '₹ ${balance}',
                  style: AppTextStyle.recharge_current_banner_text(),
                ),
                Spacer(),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondary,
                      elevation: 5,
                      shadowColor: AppColor.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Handle recharge logic
                    },
                    child: Text(
                      'Recharge Now',
                      style: AppTextStyle.body1(fontColor: AppColor.white),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Card(
              color: AppColor.white,
              elevation: 15,
              shadowColor: AppColor.primary,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image taking maximum size
                        data.imageUrl.isNotEmpty
                            ? FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(data.imageUrl, fit: BoxFit.fitHeight,),
                        )
                            : Container(
                          color: AppColor.black, // Placeholder if no image
                        ),

                        SizedBox(width: 10), // Space between image and text

                        Expanded(
                          flex: 2, // Flex to allow the text section to take more space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                data.name,
                                maxLines: 1,
                                style: AppTextStyle.body1(fontColor: AppColor.black),
                              ),
                              SizedBox(height: 5), // Space between name and fee
                              Card(
                                color: AppColor.secondary_light_green,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                                  child: Text(
                                    data.fee,
                                    style: AppTextStyle.h1(fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5), // Space between fee and expertise
                              AutoSizeText(
                                'Expertise: ${data.expertise}',
                                maxLines: 1,
                                style: AppTextStyle.body1(fontColor: AppColor.black, fontSize: 12),
                              ),
                              SizedBox(height: 5), // Space before helped count
                              Container(
                                width: double.infinity,
                                color: AppColor.black.withOpacity(0.1),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.svg_user_group),
                                      SizedBox(width: 5),
                                      Text(
                                        '${data.helped} People Helped',
                                        style: AppTextStyle.body1(fontColor: AppColor.black.withOpacity(0.5), fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.secondary,
                          elevation: 5,
                          shadowColor: AppColor.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed: () {
                          // Handle recharge logic
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconlyBold.call, color: AppColor.white, size: 18,),
                            SizedBox(width: 10,),
                            Text(
                              'Call Now',
                              style: AppTextStyle.body1(fontColor: AppColor.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    )
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

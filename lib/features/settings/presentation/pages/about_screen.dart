import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/settings/presentation/widgets/icon_widget.dart';

import '../../../../core/constants.dart';
import '../../../../core/customs/app_bar_header.dart';
import '../../../../core/customs/drawer_widget.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

import '../../../../core/theme/theme.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          const AppBarHeader(),
          screenUtil.setHeight(33).ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(text: 'About' , color:Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color,
                  size: screenUtil.setSp(35),
                  fontWeight: FontWeight.w500,
                ),
                screenUtil.setHeight(10).ph,
                Container(
                  width:screenUtil.setWidth(315),
                  height:screenUtil.setHeight(48),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: kDarkTealColor,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: CommonTextWidget(text: 'Version App 1.1.0' , size: screenUtil.setSp(18),
                      fontWeight: FontWeight.w500, textAlign: TextAlign.center, color: kWhite,),
                  ),
                ),
                screenUtil.setHeight(30).ph,
                CommonTextWidget(text: 'Contact' , color:Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .color,
                  size: screenUtil.setSp(18),
                  fontWeight: FontWeight.w500,
                ),
                screenUtil.setHeight(10).ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconWidget(icon: SvgPicture.asset(Assets.mail ,fit: BoxFit.none)),
                      IconWidget(icon: SvgPicture.asset(Assets.telegram ,fit: BoxFit.none)),
                      IconWidget(icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(Assets.whats ,fit: BoxFit.none),
                          SvgPicture.asset(Assets.whatsPhone ,fit: BoxFit.none)
                        ],
                      )),
                  ],),
                ),
                screenUtil.setHeight(30).ph,
                CommonTextWidget(text: 'Description' , color:Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .color,
                  size: screenUtil.setSp(18),
                  fontWeight: FontWeight.w500,
                ),
                screenUtil.setHeight(5).ph,
                CommonTextWidget(text: 'Line VPN protects your online privacy with state-of-the-art encryption. Whether on public Wi-Fi or accessing sensitive data, our global servers ensure fast, reliable, and anonymous browsing, bypassing geo-blocks for unrestricted internet access.',
                  color:Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .color,
                  fontWeight: FontWeight.w400,
                  size: screenUtil.setSp(16),
                  height: 1.8,

                ),
                screenUtil.setHeight(30).ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonTextWidget(text: 'Terms of Service',color:Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color,
                        fontWeight: FontWeight.w400,
                        size: screenUtil.setSp(15),
                      ),
                      Container(height: 27,width: 2,color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color,),
                      CommonTextWidget(text: 'Privacy Policy',color:Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color,
                        fontWeight: FontWeight.w400,
                        size: screenUtil.setSp(15),
                      ),
                    ],
                  ),
                ),
                screenUtil.setHeight(10).ph,
                SizedBox(
                    width:screenUtil.setWidth(315),
                    height:screenUtil.setHeight(48),
                    child: CustomButton(title: 'Ask a question', color: kPrimary , radius: 64, fontWeight: FontWeight.w500,)),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

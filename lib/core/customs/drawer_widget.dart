import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/assets.dart';

import 'list_title_drawer_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Drawer(
      width: double.infinity,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.clear,
                    color: primaryColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(Assets.sun),
                ),
              ],
            ),
            screenUtil.setHeight(30).ph,
            ListTitleDrawerWidget(
              title: 'Home',
              onTap: () {},
              isActive: true,
            ),
            ListTitleDrawerWidget(
              title: 'Profile',
              onTap: () {},
            ),
            ListTitleDrawerWidget(
              title: 'Select country',
              onTap: () {},
            ),
            ListTitleDrawerWidget(
              title: 'Tarifs',
              onTap: () {},
            ),
            ListTitleDrawerWidget(
              title: 'Safety',
              onTap: () {},
            ),
            ListTitleDrawerWidget(
              title: 'About',
              onTap: () {},
            ),
            screenUtil.setHeight(30).ph,
            ListTile(
              title: Row(
                children: [
                  SvgPicture.asset(Assets.logout),
                  14.pw,
                  CommonTextWidget(
                    text: 'Log out'.toUpperCase(),
                    size: screenUtil.setSp(18),
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

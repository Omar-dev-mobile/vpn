import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/tarif/presentation/widgets/page_view_item.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({super.key});

  @override
  _TopIconsPageViewState createState() => _TopIconsPageViewState();
}

class _TopIconsPageViewState extends State<CustomPageView> {
  int _currentIndex = 2;
  final PageController _pageController =
      PageController(viewportFraction: 1 / 3, initialPage: 2);

  final List<Map<String, String>> items = [
    {"icon": '', "title": ''},
    {"icon": Assets.allDevices, "title": LocaleKeys.allDevices.tr()},
    {"icon": Assets.highSpeed, "title": LocaleKeys.highSpeed.tr()},
    {"icon": Assets.moneyBack, "title": LocaleKeys.moneyBack.tr()},
    {"icon": Assets.trafic, "title": LocaleKeys.trafic.tr()},
    {"icon": Assets.openWorld, "title": LocaleKeys.openWorld.tr()},
    {"icon": '', "title": ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenUtil.setHeight(115),
          child: PageView.builder(
            controller: _pageController,
            physics: ClampingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            padEnds: false,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: PageViewItem(
                  icon: items[index]["icon"]!,
                  title: items[index]["title"]!,
                ),
              );
            },
          ),
        ),
        12.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(items.length - 2, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? kPrimary
                    : Theme.of(context).disabledColor,
              ),
            );
          }),
        ),
      ],
    );
  }
}

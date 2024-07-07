import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/tarif/presentation/widgets/page_view_item.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({super.key});

  @override
  _TopIconsPageViewState createState() => _TopIconsPageViewState();
}

class _TopIconsPageViewState extends State<CustomPageView> {
  int _currentIndex = 0;
  final PageController _pageController =
      PageController(viewportFraction: 1 / 3, initialPage: 1);

  final List<Map<String, String>> items = [
    {"icon": Assets.pageView1, "title": "Money back"},
    {"icon": Assets.pageView2, "title": "Traffic"},
    {"icon": Assets.pageView3, "title": "Open world"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenUtil.setHeight(115),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
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
          children: List.generate(items.length, (index) {
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

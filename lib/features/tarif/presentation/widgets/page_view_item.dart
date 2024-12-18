import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.icon, required this.title});

  final String icon, title;
  @override
  Widget build(BuildContext context) {
    return title == '' ? SizedBox() : Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          12.ph,
          SvgPicture.asset(icon),
          const Spacer(),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).textTheme.headlineMedium?.color),
              ),
            ),
          ),
          12.ph
        ],
      ),
    );
  }
}

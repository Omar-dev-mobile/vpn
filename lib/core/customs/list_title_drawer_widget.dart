import 'package:flutter/material.dart';

import '../constants.dart';
import 'common_text_widget.dart';

class ListTitleDrawerWidget extends StatelessWidget {
  const ListTitleDrawerWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  final String title;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        screenUtil.setHeight(30).ph,
        ListTile(
          title: CommonTextWidget(
            text: title.toUpperCase(),
            color: isActive ? Colors.black : primaryColor,
            size: screenUtil.setSp(30),
            fontWeight: FontWeight.w300,
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}

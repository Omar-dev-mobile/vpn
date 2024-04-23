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
        screenUtil.setHeight(20).ph,
        ListTile(
          title: CommonTextWidget(
            text: title.toUpperCase(),
            color: isActive
                ? Theme.of(context).textTheme.titleMedium!.color
                : primaryColor,
            size: screenUtil.setSp(22),
            fontWeight: FontWeight.w400,
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}

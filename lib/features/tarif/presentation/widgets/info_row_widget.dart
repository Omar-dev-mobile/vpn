import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class InfoRowWidget extends StatelessWidget {
  const InfoRowWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(
              Icons.circle,
              color: kShadeOfGray,
              size: 4,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: CommonTextWidget(
              text: text,
              color: kShadeOfGray,
              size: 9,
              fontWeight: FontWeight.w500,
              height: 12 / 9,
            ),
          ),
        ],
      ),
    );
  }
}

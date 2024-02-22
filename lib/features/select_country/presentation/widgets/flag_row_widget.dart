import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';

class FlagRowWidget extends StatelessWidget {
  const FlagRowWidget({
    super.key,
    required this.countryCode,
    required this.countryName,
    required this.ip,
    this.isStared = false,
    this.isSelected = true,
  });

  final String countryCode;
  final String ip;
  final String countryName;
  final bool isStared;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var countryCubit = CountryCubit.get(context);
    return Row(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Flag.fromString(
                  countryCode,
                  height: 32,
                  width: 32,
                  borderRadius: 10,
                ),
              ],
            ),
            if (isSelected)
              Stack(
                children: [
                  Container(
                    height: 34,
                    width: 34,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kBackGround, // Red border color
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kSendButton, // Inner circle color
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white, // Icon color
                    ),
                  ),
                ],
              )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: CommonTextWidget(
          text: countryName,
          size: ScreenUtil().setSp(22.0),
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
          color: isSelected ? kSendButton : kSlateGray,
        )),
        GestureDetector(
          onTap: () {
            if (isStared) {
              countryCubit.removeFavoriteVpn(ip);
            } else {
              countryCubit.selectFavoritesVpn(ip);
            }
          },
          child: Icon(
            Icons.star,
            color: isStared ? kStarIconOn : kStarIconOff,
          ),
        )
      ],
    );
  }
}

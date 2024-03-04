import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';

class IconMode extends StatelessWidget {
  const IconMode({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ThemeModeCubit.get(context).toggleMode();
      },
      child: SvgPicture.asset(
        Assets.sun,
        colorFilter: ColorFilter.mode(
            Theme.of(context).textTheme.displaySmall!.color ?? Colors.white,
            BlendMode.srcIn),
      ),
    );
  }
}

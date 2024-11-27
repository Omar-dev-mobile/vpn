import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';

class IconMode extends StatelessWidget {
  const IconMode({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModeCubit = ThemeModeCubit.get(context);
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            Future.delayed(const Duration(microseconds: 20), () {
              themeModeCubit.toggleMode();
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Assets.sun,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.displaySmall?.color ??
                      Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              if (themeModeCubit.isModeLikeSystem(context))
                const Positioned(
                  child: Text(
                    'A',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

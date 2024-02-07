import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/bloc/home_cubit.dart';

import '../../../../core/customs/logo.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);

    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              homeCubit.scaffoldKey.currentState!.openEndDrawer();
            },
            child: SvgPicture.asset(Assets.nav),
          ),
          const Spacer(),
          const Logo(),
          const Spacer(),
          SvgPicture.asset(Assets.sun),
        ],
      ),
    );
  }
}

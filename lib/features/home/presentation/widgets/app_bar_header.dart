import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/customs/logo.dart';
import '../bloc/bottom_nav_bar_cubit.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavBarCubit = BottomNavBarCubit.get(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                bottomNavBarCubit.scaffoldKey.currentState!.openEndDrawer();
              },
              child: SvgPicture.asset('assets/icons/nav.svg'),
            ),
            const Spacer(),
            const Logo(),
            const Spacer(),
            SvgPicture.asset('assets/icons/sun.svg'),
          ],
        ),
      ),
    );
  }
}

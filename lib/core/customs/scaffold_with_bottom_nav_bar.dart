import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../features/home/presentation/bloc/bottom_nav_bar_cubit.dart';
import 'bottom_navigation_bar_widget.dart';
import 'drawer_widget.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    Key? key,
    required this.body,
    required this.onPressed,
    this.withDrawer = true,
    this.withBottomNavBar = true,
  }) : super(key: key);
  final Widget body;
  final Function(int index) onPressed;
  final bool withDrawer;
  final bool withBottomNavBar;

  @override
  Widget build(BuildContext context) {
    final bottomNavBarCubit = BottomNavBarCubit.get(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: bottomNavBarCubit.scaffoldKey,
            endDrawer: const DrawerWidget(),
            resizeToAvoidBottomInset: true,
            extendBody: true,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(5.0),
              child: withBottomNavBar
                  ? SvgPicture.asset('assets/icons/home_icon.svg')
                  : const SizedBox.shrink(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: withBottomNavBar
                ? BottomNavigationBarWidget(
                    onTap: onPressed,
                  )
                : const SizedBox.shrink(),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: SingleChildScrollView(
              child: body,
            ),
          );
        },
      ),
    );
  }
}

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/bottom_navigation_bar_widget.dart';
import 'package:vpn/core/customs/logo.dart';
import 'package:vpn/core/customs/scaffold_with_bottom_nav_bar.dart';
import 'package:vpn/core/theme.dart';

import '../../../../core/customs/common_text_widget.dart';
import '../bloc/bottom_nav_bar_cubit.dart';
import '../widgets/app_bar_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavBarCubit = BottomNavBarCubit.get(context);
    return ScaffoldWithBottomNavBar(
      body: bottomNavBarCubit.builder(bottomNavBarCubit.index),
      onPressed: (int index) {
        bottomNavBarCubit.updateNavBar(index);
      },
    );

  }
}

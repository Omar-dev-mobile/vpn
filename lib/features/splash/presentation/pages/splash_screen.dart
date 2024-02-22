import 'dart:async';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gif/gif.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/splash/presentation/bloc/splash_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  route() async {
    context.replaceRoute(const HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: Center(
          child: FlutterSplashScreen(
        duration: const Duration(seconds: 4),
        backgroundColor: kPrimary,
        onEnd: route,
        splashScreenBody: Center(
          child: Lottie.asset(
            Assets.lottieSplashAnimation,
          ),
        ),
      )),
    );
  }
}

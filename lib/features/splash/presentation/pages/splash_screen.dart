import 'dart:async';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gif/gif.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  // startTimer() async {
  //   var dur = const Duration(seconds: 10);
  //   return Timer(dur, route);
  // }

  route() async {
    FlutterNativeSplash.remove();
    context.replaceRoute(const HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlutterSplashScreen(
        duration: const Duration(seconds: 4),
        backgroundColor: kPrimary,
        onEnd: route,
        splashScreenBody: Center(
          child: Lottie.asset(
            'assets/images/lottie_animation.json',
          ),
        ),
      )),
    );
  }
}

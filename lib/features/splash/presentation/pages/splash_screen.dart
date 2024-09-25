import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/locator.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirst = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkFirstRun();
    });
    super.initState();
  }

  Future checkFirstRun() async {
    isFirst = await locator<CacheHelper>().getFirstRun();
  }

  route() async {
    print(isFirst);
    if (isFirst) {
      context.replaceRoute(const PrivacyPolicyRoute());
      locator<CacheHelper>().saveFirstRun(false);
    } else {
      context.replaceRoute(const MainRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlutterSplashScreen(
        duration: const Duration(seconds: 4),
        backgroundColor: kPrimary,
        onEnd: route,
        splashScreenBody: SizedBox(
          width: screenUtil.screenWidth,
          child: Center(
            child: Lottie.asset(
              Assets.lottieSplashAnimation,
            ),
          ),
        ),
      )),
    );
  }
}

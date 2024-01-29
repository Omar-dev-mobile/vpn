import 'package:flutter/cupertino.dart';
import 'package:vpn/core/routes/routes_name.dart';

import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';


class RoutesPage {
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.home: (context) => const HomeScreen(),
    Routes.splash: (context) => const SplashScreen(),
  };
}

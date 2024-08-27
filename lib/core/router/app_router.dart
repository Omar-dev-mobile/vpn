import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:vpn/features/auth/presentation/pages/login_screen.dart';
import 'package:vpn/features/home/presentation/pages/activate_tarif_screen.dart';
import 'package:vpn/features/home/presentation/pages/main_screen.dart';
import 'package:vpn/features/profile/presentation/pages/profile_screen.dart';
import 'package:vpn/features/select_country/presentation/pages/select_country_screen.dart';
import 'package:vpn/features/splash/presentation/pages/app_usage_screen.dart';
import 'package:vpn/features/splash/presentation/pages/privacy_policy_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/settings/presentation/pages/about_screen.dart';
import '../../features/settings/presentation/pages/appeal_screen.dart';
import '../../features/settings/presentation/pages/ask_question_screen.dart';
import '../../features/settings/presentation/pages/web_view_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/tarif/presentation/pages/tarif_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: AboutRoute.page,
          path: '/',
        ),
        AutoRoute(page: AppealRoute.page, path: '/'),
        AutoRoute(page: AskQuestionRoute.page, path: '/'),
        AutoRoute(page: WebViewRoute.page, path: '/'),
        AutoRoute(
          page: TarifRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: PrivacyPolicyRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: SelectCountryRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: '/',
        ),
        AutoRoute(page: AppUsageRoute.page, path: '/'),
        AutoRoute(page: ActivateTarifRoute.page, path: '/')
      ];
}

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/logger.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';

import 'core/shared/components/providers.dart';
import 'core/theme/theme.dart';
import 'locator.dart';

class VpnApp extends StatelessWidget {
  const VpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            }
          },
          child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
            builder: (context, state) {
              final logicAppCubit = locator<ThemeModeCubit>();
              return FocusDetector(
                onForegroundGained: () {
                  MainCubit.get(context).verifySubscription();
                  logger.info(
                    'Foreground Gained.'
                    '\nIt means, for example, that the user switched back to your app or turned the '
                    'device\'s screen back on while your widget was visible.',
                  );
                },
                child: MaterialApp.router(
                  color: kBlack,
                  title: 'VPN Candodream',
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: child!,
                    );
                  },
                  localizationsDelegates: context.localizationDelegates,
                  locale: DevicePreview.locale(context),
                  supportedLocales: context.supportedLocales,
                  theme: MyThemeData.lightTheme(),
                  darkTheme: MyThemeData.darkTheme(),
                  themeMode: logicAppCubit.getThemeMode(context),
                  routerConfig: locator<AppRouter>().config(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

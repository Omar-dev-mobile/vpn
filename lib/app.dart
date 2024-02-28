import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';

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
              return MaterialApp.router(
                color: kBlack,
                key: navigatorKey,
                supportedLocales: const [Locale('en')],
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: child!,
                  );
                },
                theme: MyThemeData.lightTheme(),
                darkTheme: MyThemeData.darkTheme(),
                themeMode: logicAppCubit.getThemeMode(context),
                routerConfig: locator<AppRouter>().config(),
              );
            },
          ),
        ),
      ),
    );
  }
}

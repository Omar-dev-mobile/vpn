import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/router/app_router.dart';

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
          child: MaterialApp.router(
            color: kBlack,
            supportedLocales: const [Locale('en')],
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            theme: MyThemeData.lightTheme(), // Use the light theme
            darkTheme: MyThemeData.darkTheme(), // Use the dark theme
            themeMode: ThemeMode.system,
            routerConfig: locator<AppRouter>().config(),
          ),
        ),
      ),
    );
  }
}

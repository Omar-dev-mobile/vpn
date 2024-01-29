import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/routes/routes_name.dart';

import 'core/routes/routes_page.dart';
import 'core/shared/components/providers.dart';
import 'core/theme.dart';

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
        child: MaterialApp(
          supportedLocales: const [Locale('en')],
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          initialRoute: Routes.splash,
          theme: MyThemeData.lightTheme(), // Use the light theme
          darkTheme: MyThemeData.darkTheme(), // Use the dark theme
          themeMode: ThemeMode.system,
          routes: RoutesPage.routes,
        ),
      ),
    );
  }
}

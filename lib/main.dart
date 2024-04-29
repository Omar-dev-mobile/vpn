import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/app.dart';
import 'package:vpn/core/init_app.dart';
import 'package:vpn/core/shared/logger.dart';
import 'package:vpn/translations/codegen_loader.g.dart';

void main() async {
  await InitApp.initialize();
  logger.runLogging(
    () => runApp(
      EasyLocalization(
        assetLoader: const CodegenLoader(),
        supportedLocales: const [
          Locale('ru'),
          Locale('en'),
          Locale('es'),
          Locale('de'),
          Locale('cn')
        ],
        path: 'lib/translations',
        fallbackLocale: const Locale('en'),
        child: const VpnApp(),
      ),
    ),
    const LogOptions(),
  );
}

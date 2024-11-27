
import 'package:device_preview/device_preview.dart';
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
          // Locale('ru'),
          Locale('en'),
          Locale('es'),
          Locale('de'),
          Locale.fromSubtags(languageCode: 'zh'), // generic Chinese
        ],
        path: 'lib/translations',
        fallbackLocale: const Locale('en'),

        child: DevicePreview(
           enabled: false,
          builder: (context) => const VpnApp()),
      ),
    ),
    const LogOptions(),
  );
}

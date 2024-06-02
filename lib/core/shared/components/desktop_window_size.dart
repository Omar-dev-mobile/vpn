import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future setWindowFunctions() async {
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    // size: Size(700, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    // minimumSize: Size(700, 800),
    // maximumSize: Size(700, 800),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

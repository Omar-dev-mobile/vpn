import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<String> isSandboxOrProduct() async {
  if (kDebugMode) {
    return 'sandbox';
  } else {
    final isTestFlight = await _isTestFlight();
    if (isTestFlight) {
      return 'sandbox';
    } else {
      return 'product';
    }
  }
}

Future<bool> _isTestFlight() async {
  const platform = MethodChannel('app/testflight');
  try {
    final bool result = await platform.invokeMethod('isTestFlight');
    return result;
  } on PlatformException catch (e) {
    print("Failed to get TestFlight status: '${e.message}'.");
    return false;
  }
}

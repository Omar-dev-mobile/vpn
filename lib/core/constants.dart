import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';

const BASE_URL = 'https://vp-line.aysec.org/ios.php';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

final screenUtil = ScreenUtil();

ConnectionStatus emptyConnectionStatus = ConnectionStatus(
    status: StatusConnection.Stopped, lastMcc: null, dateConnection: null);

ConnectionStatus deInternetConnectionStatus = ConnectionStatus(
    status: StatusConnection.Offline, lastMcc: null, dateConnection: null);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

int getNumberOfDecimalDigits(double number) {
  String numStr = number.toString();
  int decimalIndex = numStr.indexOf('.');
  if (decimalIndex != -1) {
    String decimalPart = numStr.substring(decimalIndex + 1);
    int nonZeroDigitsCount = decimalPart.length;
    for (int i = decimalPart.length - 1; i >= 0; i--) {
      if (decimalPart[i] != '0') {
        break;
      }
      nonZeroDigitsCount--;
    }
    return nonZeroDigitsCount;
  }
  return 0;
}

const tarifCost = {
  "week": 7,
  "month": 30,
  "year": 365,
};

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/translations/codegen_loader.g.dart';

const BASE_URL = 'https://vp-line.aysec.org/ios.php';
const termServiceUrl = 'https://candodream.com/termsofservice';
const policyUrl = 'https://candodream.com/policy';

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
  "3month": 90,
};

double getPercent(DateTime? vpnTimeExpire, String tarifName) {
  if (vpnTimeExpire == null) {
    return 1;
  }
  int difference = vpnTimeExpire.difference(DateTime.now()).inDays;
  double percentTry = (difference / (tarifCost[tarifName.toLowerCase()] ?? 0));
  return (percentTry > 1 && percentTry < 0) ? 1 : (1 - percentTry);
}

int random(int min, int max) {
  return min + Random().nextInt(max - min);
}

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);
  return value == null || value.isEmpty || !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

T? first<T>(List<T> list) {
  return list.isNotEmpty ? list.first : null;
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

String getlocaleName() {
  final localeStr = Platform.localeName;
  final loc = localeStr.split('_')[0];
  if (CodegenLoader.mapLocales.containsKey(loc)) {
    return loc;
  } else {
    return "en";
  }
}

const kProductIds = [
  'org.cnddrm.vplineapp.pay.sub.week',
  'org.cnddrm.vplineapp.pay.sub.month',
  'org.cnddrm.vplineapp.pay.sub.triple.month'
];

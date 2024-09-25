import 'dart:io';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/translations/codegen_loader.g.dart';
import 'package:vpn/translations/locate_keys.g.dart';

// const BASE_URL = 'https://vp-line.aysec.org/ios.php';
const BASE_URL = 'https://app.candodream.com/ios.php';

const verifyReceiptUrl = kDebugMode
    ? 'https://sandbox.itunes.apple.com/verifyReceipt'
    : "https://buy.itunes.apple.com/verifyReceipt";

const termServiceUrl = 'https://app.candodream.com/terms.php';
const policyUrl = 'https://app.candodream.com/privacy.php';

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

Map tarifCost = {
  kProductIds[0]: 7,
  kProductIds[1]: 30,
  kProductIds[2]: 90,
};

double getPercent(DateTime? vpnTimeExpire, String prodactId) {
  if (vpnTimeExpire == null) {
    return 1;
  }
  int difference = vpnTimeExpire.difference(DateTime.now()).inDays;
  double percentTry = (difference / (tarifCost[prodactId] ?? 0));
  return (percentTry > 1 || percentTry < 0) ? 1 : (1 - percentTry);
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
      ? LocaleKeys.enterAValidEmailAddress.tr()
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
    return loc == "zh" ? "cn" : loc;
  } else {
    return "en";
  }
}

const kProductIds = [
  'org.cnddrm.vplineapp.pay.sub.week',
  'org.cnddrm.vplineapp.pay.sub.month',
  'org.cnddrm.vplineapp.pay.sub.triple.month'
];

String getDaysRemainingText(int count) {
  final plural = Intl.plural(
    count,
    zero:
        '${LocaleKeys.no.tr()} ${LocaleKeys.days.tr()}', // Normally, for zero you would use the plural form
    one: '$count ${LocaleKeys.dayTime.tr()}', // 1 день
    few: '$count ${LocaleKeys.day.tr()}', // 2-4 дня
    many:
        '$count ${LocaleKeys.days.tr()}', // 5-20 дней, and all numbers ending in 5-9 or 0
    other:
        '$count ${LocaleKeys.days.tr()}', // Used for some exceptional cases if any
    locale: getlocaleName(),
  );
  return plural;
}

int calculateDaysLeft(DateTime? expireDate) {
  if (expireDate == null) {
    return 0;
  }
  DateTime now = DateTime.now();
  Duration difference = expireDate.difference(now);

  // Возвращает количество дней до истечения срока, или 1, если осталось менее 24 часов
  return difference.inHours < 24 ? 1 : difference.inDays + 1;
}

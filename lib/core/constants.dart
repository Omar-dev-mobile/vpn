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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const BASE_URL = '';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

final screenUtil = ScreenUtil();
final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();

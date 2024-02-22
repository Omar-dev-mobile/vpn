import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/theme/theme.dart';

class CustomSnackBar {
  static badSnackBar(BuildContext context, String data) {
    CherryToast.error(
            borderRadius: 12,
            displayCloseButton: false,
            title: const Text(
              "Error",
              style: TextStyle(
                  color: kDarkBluishGray, fontSize: 16, fontFamily: 'Saira'),
            ),
            description: Text(
              data,
              style: const TextStyle(
                  color: kDarkBluishGray, fontSize: 14, fontFamily: 'Saira'),
            ),
            animationType: AnimationType.fromRight,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true)
        .show(context);
  }

  static goodSnackBar(BuildContext context, final data) {
    CherryToast.success(
      borderRadius: 12,
      displayCloseButton: false,
      title: const Text(
        "Success",
        style: TextStyle(
            color: kDarkBluishGray, fontSize: 16, fontFamily: 'Saira'),
      ),
      description: Text(
        data,
        style: const TextStyle(
            color: kDarkBluishGray, fontSize: 14, fontFamily: 'Saira'),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);
  }
}

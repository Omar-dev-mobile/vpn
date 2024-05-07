import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn/translations/locate_keys.g.dart';

Future customDialog(
  BuildContext context,
  String title,
  Function() function,
) async {
  await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(LocaleKeys.no.tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              onPressed: function,
              child: Text(LocaleKeys.yes.tr()),
            ),
          ],
        );
      });
}

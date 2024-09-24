import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/log_out_and_delete_account.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          SvgPicture.asset(
            Assets.bin,
          ),
          22.pw,
          CommonTextWidget(
            text: LocaleKeys.deleteAccount.tr().toUpperCase(),
            size: screenUtil.setSp(18),
            color: Theme.of(context).textTheme.labelLarge!.color,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
      onTap: () async {
        showModalBottomSheetDeleteAccount(context);
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/date_utils_format.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/profile/presentation/widgets/profile_widget.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class ProfileWithoutSub extends StatelessWidget {
  const ProfileWithoutSub({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);
    return Column(
      children: [
        const AppBarHeader(
          isClose: true,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                (screenUtil.screenHeight * 0.1).ph,
                ProfileWidget(
                  text: profileCubit.workStatus,
                  title: LocaleKeys.yourKey.tr(),
                  asset: Assets.profileKey,
                ),
                40.ph,
                ProfileWidget(
                  text: DateUtilsFormat.convertDateTime(DateTime.tryParse(
                      profileModel.workStatus?.userInfo?.dateLastLogin ?? "")),
                  title: LocaleKeys.lastLogin.tr(),
                  asset: Assets.time,
                ),
                const Spacer(),
                CommonTextWidget(
                  text: LocaleKeys
                      .purchaseASubscriptionForContinuedAccessAndFunctionality
                      .tr(),
                  size: 23,
                  textAlign: TextAlign.center,
                  color: Theme.of(context).textTheme.displaySmall!.color,
                ),
                20.ph,
                CustomButton(
                  title: LocaleKeys.viewPlans.tr(),
                  color: kDarkGreen,
                  size: 20,
                  onPressed: () {
                    TarifCubit.get(context).getTrials();
                    context.pushRoute(const TarifRoute());
                  },
                  fontWeight: FontWeight.w500,
                ),
                screenUtil.setHeight(20).ph,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

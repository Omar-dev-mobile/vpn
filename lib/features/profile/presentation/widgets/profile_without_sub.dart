import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/widgets.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
=======
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/log_out_and_delete_account.dart';
import 'package:vpn/core/customs/roundedButton.dart';
>>>>>>> new_version
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/date_utils_format.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
<<<<<<< HEAD
import 'package:vpn/features/profile/presentation/widgets/profile_widget.dart';
=======
import 'package:vpn/features/profile/presentation/widgets/profile_container.dart';
>>>>>>> new_version
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
<<<<<<< HEAD
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
=======
        _buildProfileContent(context, profileCubit),
        const Spacer(),
        if (!(profileModel.workStatus?.userInfo?.userApiKey?.isEmpty ?? true))
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: LogOutAndDeleteAccount(),
          ),
        const Spacer(),
      ],
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileCubit profileCubit) {
    return Container(
      height: screenUtil.screenHeight * 0.85,
      decoration: _buildContainerDecoration(context),
      child: Column(
        children: [
          const AppBarHeader(isClose: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildProfileDetails(context, profileCubit),
            ),
          ),
          _buildViewPlansButton(context),
        ],
      ),
    );
  }

  ShapeDecoration _buildContainerDecoration(BuildContext context) {
    return ShapeDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context, ProfileCubit profileCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        14.ph,
        ProfileContainer(
          icon: SvgPicture.asset(Assets.key2),
          title: LocaleKeys.yourKey.tr(),
          text: profileCubit.workStatus,
          trailingIcon: Icons.copy,
          textSize: 35,
        ),
        40.ph,
        ProfileContainer(
          icon: SvgPicture.asset(Assets.time2),
          text: DateUtilsFormat.convertDateTime(DateTime.tryParse(
              profileModel.workStatus?.userInfo?.dateLastLogin ?? "")),
          title: LocaleKeys.lastLogin.tr(),
          textSize: 18,
        ),
        20.ph,
        CommonTextWidget(
          text: LocaleKeys
              .purchaseASubscriptionForContinuedAccessAndFunctionality
              .tr(),
          size: 15,
          fontWeight: FontWeight.w400,
          color: kShadeOfGray,
          textAlign: TextAlign.center,
        ),
        20.ph,
      ],
    );
  }

  Widget _buildViewPlansButton(BuildContext context) {
    return RoundedButton(
      name: LocaleKeys.viewPlans.tr(),
      color: kSendButton,
      colorRounded: kSendButton,
      width: screenUtil.setWidth(280),
      textColor: kWhite,
      onPressed: () {
        TarifCubit.get(context).getTrials();
        context.pushRoute(const TarifRoute());
      },
    );
  }
>>>>>>> new_version
}

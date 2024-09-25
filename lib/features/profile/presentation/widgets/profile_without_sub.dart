import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/log_out_and_delete_account.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/date_utils_format.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/profile/presentation/widgets/profile_container.dart';
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
        Container(
          height: screenUtil.screenHeight * 0.85,
          decoration: ShapeDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          child: Column(
            children: [
              const AppBarHeader(
                isClose: true,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // (screenUtil.screenHeight * 0.1).ph,
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
                            profileModel.workStatus?.userInfo?.dateLastLogin ??
                                "")),
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
                  ),
                ),
              ),
              RoundedButton(
                name: LocaleKeys.viewPlans.tr(),
                color: kSendButton,
                colorRounded: kSendButton,
                width: screenUtil.setWidth(280),
                textColor: kWhite,
                onPressed: () {
                  TarifCubit.get(context).getTrials();
                  context.pushRoute(const TarifRoute());
                },
              ),
            ],
          ),
        ),
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
}

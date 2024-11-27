import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/customs/icon_mode.dart';
import 'package:vpn/core/customs/log_out_and_delete_account.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/extensions/extension.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class ProfileWithSub extends StatelessWidget {
  const ProfileWithSub({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileHeader(context),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: LogOutAndDeleteAccount(),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      height: screenUtil.screenHeight * 0.85,
      decoration: _buildGradientDecoration(),
      child: Stack(
        children: [
          _buildProfileImage(),
          _buildProfileInfo(context),
          _buildSafeAreaControls(context),
        ],
      ),
    );
  }

  Decoration _buildGradientDecoration() {
    return ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: const Alignment(0.1, 1.5),
        colors: (gradient[
                profileModel.workStatus?.userInfo?.tarifInfo?.productId ??
                    ''] ??
            gradient['org.cnddrm.vplineapp.pay.sub.week']!),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Padding(
      padding: EdgeInsets.only(
        top: screenUtil.setHeight(60),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(Assets.circularProfile),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTarifInfo(),
          _buildTarifDetails(context),
          _buildUnsubscribeButton(),
          _buildRenewSubscriptionButton(context),
        ],
      ),
    );
  }

  Widget _buildTarifInfo() {
    return Column(
      children: [
        CommonTextWidget(
          text: profileModel.workStatus?.userInfo?.tarifInfo?.tarifName ?? "",
          color: kWhite.withOpacity(0.7),
          size: 45,
          fontWeight: FontWeight.w300,
          height: 1,
        ),
        CommonTextWidget(
          text:
              "\$${(profileModel.workStatus?.userInfo?.tarifInfo?.tarifCostActivation ?? "").fixDouble()}",
          color: kSilver,
          size: 30,
          fontWeight: FontWeight.w300,
        ),
      ],
    );
  }

  Widget _buildTarifDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          _buildTarifNameAndDaysLeft(),
          10.ph,
          _buildProgressBar(context),
        ],
      ),
    );
  }

  Widget _buildTarifNameAndDaysLeft() {
    return Row(
      children: [
        CommonTextWidget(
          text: profileModel.workStatus?.userInfo?.tarifInfo?.tarifName ?? "",
          color: kWhite,
          size: 25,
          fontWeight: FontWeight.w300,
        ),
        const Spacer(),
        CommonTextWidget(
          text: getDaysRemainingText(calculateDaysLeft(
              profileModel.workStatus?.userInfo?.vpnTimeExpire)),
          color: kWhite,
          size: 16,
          fontWeight: FontWeight.w300,
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 14.0,
      animation: true,
      barRadius: const Radius.circular(20),
      percent: profileModel.workStatus?.userInfo?.percent ?? 0,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Theme.of(context).primaryColorLight,
      progressColor: Theme.of(context).indicatorColor,
    );
  }

  Widget _buildUnsubscribeButton() {
    return CustomButton(
      title: LocaleKeys.unsubscribe.tr(),
      color: kTransparent,
      textColor: kYellowColor,
      onPressed: () {
        launchUrl(
          Uri.parse("https://apps.apple.com/account/subscriptions"),
          mode: LaunchMode.externalApplication,
        );
      },
    );
  }

  Widget _buildRenewSubscriptionButton(BuildContext context) {
    return RoundedButton(
      onPressed: () {
        TarifCubit.get(context).getTrials();
        context.pushRoute(const TarifRoute());
      },
      name: LocaleKeys.renewSubscription.tr(),
      textColor: Theme.of(context).textTheme.labelSmall!.color!,
      colorRounded: Theme.of(context).primaryColor,
      color: Theme.of(context).scaffoldBackgroundColor,
      width: screenUtil.screenWidth * 0.8,
    );
  }

  Widget _buildSafeAreaControls(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                MainCubit.get(context).verifySubscription();
                context.replaceRoute(const MainRoute());
              },
              icon: SvgPicture.asset(Assets.close),
            ),
            const Spacer(),
            _buildStatusIndicator(profileCubit),
            const Spacer(),
            const IconMode(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(ProfileCubit profileCubit) {
    return Container(
      decoration: BoxDecoration(
        color: kLightTealColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: kBlack.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: kBlack.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 7, bottom: 7),
        child: Row(
          children: [
            SvgPicture.asset(Assets.key),
            10.pw,
            CommonTextWidget(
              text: profileCubit.workStatus,
              size: 14,
              color: kWhite,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

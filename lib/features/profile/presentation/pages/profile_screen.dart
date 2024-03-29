import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_error.dart';
import 'package:vpn/core/customs/log_out.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/shared/extensions/extension.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var profileCubit = ProfileCubit.get(context);
          if (state is ProfileErrorState) {
            return CustomError(
              error: state.error,
            );
          } else if (state is ProfileSuccessState) {
            final profileModel = state.profileModel;
            return Column(
              children: [
                Container(
                  height: screenUtil.screenHeight * 0.85,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0.1, 1.5),
                      colors: [kDeepPurpleColor, kDarkTealColor],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenUtil.setHeight(60),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(Assets.circularProfile),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                CommonTextWidget(
                                  text: profileModel.workStatus?.userInfo
                                          ?.tarifInfo?.tarifName ??
                                      "",
                                  color: kWhite.withOpacity(0.7),
                                  size: screenUtil.setSp(45),
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                ),
                                CommonTextWidget(
                                  text:
                                      "\$${(profileModel.workStatus?.userInfo?.tarifInfo?.tarifCostActivation ?? "").fixDouble()}",
                                  color: kSilver,
                                  size: screenUtil.setSp(30),
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CommonTextWidget(
                                        text: profileModel.workStatus?.userInfo
                                                ?.tarifInfo?.tarifName ??
                                            "",
                                        color: kWhite,
                                        size: screenUtil.setSp(25),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      const Spacer(),
                                      CommonTextWidget(
                                        text:
                                            "${(profileModel.workStatus?.userInfo?.tarifInfo?.tarifDays ?? "")} days",
                                        color: kWhite,
                                        size: screenUtil.setSp(15),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ],
                                  ),
                                  10.ph,
                                  LinearPercentIndicator(
                                    lineHeight: 14.0,
                                    animation: true,
                                    barRadius: const Radius.circular(20),
                                    percent: profileModel
                                            .workStatus?.userInfo?.percent ??
                                        0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                    progressColor:
                                        Theme.of(context).indicatorColor,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: RoundedButton(
                                name: 'Upgrade',
                                textColor: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .color!,
                                colorRounded: Theme.of(context).primaryColor,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: screenUtil.screenWidth * 0.8,
                              ),
                            )
                          ],
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, right: 20),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.maybePop();
                                },
                                icon: SvgPicture.asset(Assets.close),
                              ),
                              const Spacer(),
                              Container(
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
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18, top: 7, bottom: 7),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const LogOut(),
                const Spacer(),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/customs/custom_dialog.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class LogOutAndDeleteAccount extends StatelessWidget {
  const LogOutAndDeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            await customDialog(
                context, LocaleKeys.areYouSureYouWantToLogOut.tr(), () async {
              Navigator.pop(context);
              var res = await SettingCubit.get(context).logout(context);
              if (res) {
                locator<CacheHelper>().removeUser().then((value) async {
                  final homeCubit = HomeCubit.get(context);
                  if (homeCubit.isOnline && !homeCubit.inProgress) {
                    homeCubit.stopVpnConnecting(context, showDialog: false);
                  }
                  locator<CacheHelper>().clearData();
                  locator<SystemInfoService>().dispose();
                  MainCubit.get(context).getDataServiceAcc();
                  AutoRouter.of(context).pushAndPopUntil(const MainRoute(),
                      predicate: (_) => false);
                });
              }
            });
          },
          child: Row(
            children: [
              SvgPicture.asset(Assets.logout),
              14.pw,
              CommonTextWidget(
                text: LocaleKeys.logOut.tr().toUpperCase(),
                size: screenUtil.setSp(18),
                color: Theme.of(context).textTheme.labelLarge!.color,
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              isDismissible: false,

              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              context: context,
              backgroundColor: Theme.of(context)
                  .cardColor, // Optional: makes the corners rounded

              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 35),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            Assets.close,
                            colorFilter:
                                ColorFilter.mode(kPrimary, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      Spacer(),
                      Center(child: SvgPicture.asset(Assets.deleteAccount)),
                      Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CommonTextWidget(
                            text: LocaleKeys
                                .areYouSureYouWantToDeleteYourAccount
                                .tr(),
                            size: 20,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: RoundedButton(
                                name: 'Yes',
                                color: kGreenColor,
                                onPressed: () async {
                                  var res = await SettingCubit.get(context)
                                      .logout(context, isDelete: true);
                                  if (res) {
                                    locator<CacheHelper>()
                                        .removeUser()
                                        .then((value) async {
                                      final homeCubit = HomeCubit.get(context);
                                      if (homeCubit.isOnline &&
                                          !homeCubit.inProgress) {
                                        homeCubit.stopVpnConnecting(context,
                                            showDialog: false);
                                      }
                                      locator<CacheHelper>().clearData();
                                      locator<SystemInfoService>().dispose();
                                      MainCubit.get(context)
                                          .getDataServiceAcc();
                                      AutoRouter.of(context).pushAndPopUntil(
                                          const MainRoute(),
                                          predicate: (_) => false);
                                    });
                                  }
                                },
                                colorRounded: kGreenColor,
                                width: 130),
                          ),
                          Expanded(
                            child: CustomButton(
                              title: 'No',
                              textColor: Colors.red,
                              onPressed: () => Navigator.of(context).pop(),
                              color: Colors.transparent,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: SvgPicture.asset(Assets.bin),
        ),
      ],
    );
  }
}

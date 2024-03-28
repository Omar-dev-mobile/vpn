import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/widgets/date_connection.dart';
import 'package:vpn/features/home/presentation/widgets/network_speed_checker.dart';

import '../../../../core/constants.dart';

class InfoVpnWidget extends StatelessWidget {
  const InfoVpnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color? displaySmall = Theme.of(context).textTheme.displaySmall!.color;
    final homeCubit = HomeCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Row(
            children: [
              if (homeCubit.isConnecting || homeCubit.isStopped) const Spacer(),
              Column(
                children: [
                  CommonTextWidget(
                    text: homeCubit.getStatusVpn(),
                    size: screenUtil.setSp(35),
                    color: primaryColor,
                  ),
                  if (homeCubit.statusConnection.dateConnection != null)
                    DateConnection(
                      date: homeCubit.statusConnection.dateConnection!,
                    ),
                  if (homeCubit.isOnline)
                    CommonTextWidget(
                      text: homeCubit.systemInfoService.vpnInfo?.s ?? "",
                      size: screenUtil.setSp(16),
                      color: kShadeOfGray,
                    ),
                ],
              ),
              const Spacer(),
              NetworkSpeedChecker(
                isOnline: homeCubit.isOnline,
              )
            ],
          );
        },
      ),
    );
  }
}

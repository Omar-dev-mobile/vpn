import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/translations/locate_keys.g.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          const AppBarHeader(),
          Expanded(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessState) {
                  MainCubit.get(context).getDataServiceAcc();
                  AutoRouter.of(context).pushAndPopUntil(const MainRoute(),
                      predicate: (_) => false);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const Spacer(),
                    _buildAuthContent(context, state),
                    screenUtil.setHeight(20).ph,
                    _buildAppleSignInButton(context, state),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppleSignInButton(BuildContext context, AuthState state) {
    return RoundedButton(
      onPressed: () {
        context.read<AuthBloc>().add(LoginWithAppleAuthEvent());
      },
      width: screenUtil.setWidth(300),
      name: LocaleKeys.signInWithApple.tr(),
      widget: SvgPicture.asset(Assets.iconApple),
      color: kCharcoal,
      colorRounded: kCharcoal,
      isLoading: state is AuthLoadingAppleState,
    );
  }

  Widget _buildAuthContent(BuildContext context, AuthState state) => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check,
                color: kGreenColor,
                size: 100,
              ),
              CommonTextWidget(
                text: LocaleKeys.unlockSocialMediaAnywhereAnywhere.tr(),
                size: 35,
                color: Theme.of(context).textTheme.headlineMedium!.color,
                height: 1.2,
              ),
            ],
          ),
        ),
      );
}

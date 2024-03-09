import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/auth/presentation/bloc/auth_bloc.dart';

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
          screenUtil.setHeight(50).ph,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    context.replaceRoute(const MainRoute());
                  }
                },
                builder: (context, state) {
                  return ListView(
                    children: [
                      CommonTextWidget(
                        text: 'Unlock social media\nAnywhere\nAnytime',
                        size: screenUtil.setSp(35),
                        color: Theme.of(context).textTheme.displaySmall!.color,
                        height: 1.2,
                      ),
                      screenUtil.setHeight(100).ph,
                      CustomButton(
                        title: 'Sign in with Apple',
                        color: kBlack,
                        radius: 64,
                        onPressed: () {
                          context.read<AuthBloc>().add(
                              const LoginWithGoogleAndAppleAuthEvent(
                                  type: 'apple'));
                        },
                        isLoading: state is AuthLoadingState,
                        widget: SvgPicture.asset(Assets.iconApple),
                      ),
                      screenUtil.setHeight(20).ph,
                      CustomButton(
                        title: 'Sign in with google',
                        color: kPrimary,
                        radius: 64,
                        onPressed: () {
                          AuthBloc.get(context).add(
                              const LoginWithGoogleAndAppleAuthEvent(
                                  type: 'google'));
                        },
                        widget: SvgPicture.asset(Assets.iconGoogle),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

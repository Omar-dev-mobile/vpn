import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme.dart';
import 'package:vpn/features/splash/presentation/bloc/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    SplashCubit.get(context).changeActiveImage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTeal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            BlocBuilder<SplashCubit, SplashState>(
              builder: (context, state) {
                if (state is SplashImageChanged) {
                  return Image.asset(state.activeImage);
                } else {
                  return Image.asset('assets/images/splash.png',width: 500,);
                }
              },
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CommonTextWidget(
                text: 'VPN Line v1.1',
                size: screenUtil.setSp(18),
                color: kWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}

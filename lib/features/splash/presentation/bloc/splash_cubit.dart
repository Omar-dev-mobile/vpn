import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/app_router.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(context) => BlocProvider.of(context);

  String activeImage = 'assets/images/splash.png';

  List<String> listSplash = [
    'assets/images/splash.png',
    'assets/images/vpn_link.png',
    'assets/images/vpn_link1.png',
    'assets/images/vpn_link2.png',
  ];
  Timer? timer;

  void changeActiveImage(BuildContext context) {
    timer = Timer.periodic(const Duration(seconds: 1), (timers) {
      int currentIndex = listSplash.indexOf(activeImage);
      if (currentIndex >= 3) {
        timer!.cancel();
        Navigator.pushNamedAndRemoveUntil(
            context, HomeRoute.name, (route) => false);
        return;
      }
      activeImage = listSplash[currentIndex + 1];
      emit(SplashImageChanged(activeImage));
    });
  }
}

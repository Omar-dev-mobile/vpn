import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vpn/core/routes/routes_name.dart';

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

  void changeActiveImage(context) {
    timer= Timer.periodic(const Duration(seconds: 1), (timer) {
      activeImage = getNextImage(context);
      emit(SplashImageChanged(activeImage));
    });
  }

  String getNextImage(context) {
    int currentIndex = listSplash.indexOf(activeImage);
    if (currentIndex == 3) {
      timer!.cancel();
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    }
    int nextIndex = (currentIndex + 1) % listSplash.length;
    return listSplash[nextIndex];
  }
}

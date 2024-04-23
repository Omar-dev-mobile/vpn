import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/locator.dart';

part 'theme_mode_state.dart';

// ignore: constant_identifier_names
enum ThemeModeApp { LIGHT, DARK }

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeStateInitial());

  static ThemeModeCubit get(context) => BlocProvider.of(context);

  final cacheHelper = locator<CacheHelper>();
  final systemInfoService = locator<SystemInfoService>();

  void toggleMode() {
    emit(LoadingThemeModeAppState());
    final model = themeMode == 'dark' ? "light" : "dark";
    cacheHelper.saveThemeMode(model);
    systemInfoService.themeMode = model;
    emit(SuccessThemeModeAppState());
  }

  String themeMode = "";

  bool isModeLikeSystem(context) =>
      MediaQuery.of(context).platformBrightness ==
      (themeMode == "light" ? Brightness.light : Brightness.dark);

  ThemeMode getThemeMode(context) {
    final cachedThemeMode = locator<SystemInfoService>().themeMode;
    if (cachedThemeMode == null) {
      final mode = MediaQuery.of(context).platformBrightness == Brightness.light
          ? "light"
          : "dark";
      cacheHelper.saveThemeMode(mode);
      print(mode);
      themeMode = mode;
      return ThemeMode.system;
    }
    themeMode = cachedThemeMode;
    return cachedThemeMode == "light" ? ThemeMode.light : ThemeMode.dark;
  }
}

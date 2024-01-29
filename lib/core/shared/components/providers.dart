

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vpn/locator.dart';

import '../../../features/home/presentation/bloc/bottom_nav_bar_cubit.dart';
import '../../../features/home/presentation/bloc/home_cubit.dart';
import '../../../features/splash/presentation/bloc/splash_cubit.dart';

List<SingleChildWidget> providers = [
  BlocProvider(create: (_) => locator<BottomNavBarCubit>()),
  BlocProvider(create: (_) => locator<HomeCubit>()),
  BlocProvider(create: (_) => locator<SplashCubit>()),
];

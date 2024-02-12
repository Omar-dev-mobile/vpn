import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vpn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vpn/locator.dart';

import '../../../features/home/presentation/bloc/home_cubit.dart';
import '../../../features/splash/presentation/bloc/splash_cubit.dart';

List<SingleChildWidget> providers = [
  BlocProvider(create: (_) => locator<HomeCubit>()),
  BlocProvider(create: (_) => locator<SplashCubit>()),
  BlocProvider(create: (_) => locator<AuthBloc>()),
];

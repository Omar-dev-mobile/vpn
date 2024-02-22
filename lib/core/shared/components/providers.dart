import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vpn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vpn/features/home/presentation/logic/cubit/home_cubit.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:vpn/locator.dart';

List<SingleChildWidget> providers = [
  BlocProvider(create: (_) => locator<HomeCubit>()),
  BlocProvider(create: (_) => locator<SplashCubit>()),
  BlocProvider(create: (_) => locator<AuthBloc>()),
  BlocProvider(create: (_) => locator<CountryCubit>()),
];

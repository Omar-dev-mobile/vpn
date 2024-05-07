import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/locator.dart';

List<SingleChildWidget> providers = [
  BlocProvider(create: (_) => locator<HomeCubit>()),
  BlocProvider(create: (_) => locator<AuthBloc>()),
  BlocProvider(create: (_) => locator<CountryCubit>()),
  BlocProvider(create: (_) => locator<ThemeModeCubit>()),
  BlocProvider(create: (_) => locator<MainCubit>()),
  BlocProvider(create: (_) => locator<ProfileCubit>()),
  BlocProvider(create: (_) => locator<SettingCubit>()),
  BlocProvider(create: (_) => locator<PurchasesCubit>()),
  BlocProvider(create: (_) => locator<TarifCubit>()),
];

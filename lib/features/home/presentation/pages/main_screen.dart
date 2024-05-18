import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/custom_error.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/home/presentation/pages/home_screen.dart';
import 'package:vpn/translations/locate_keys.g.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mainCubit = MainCubit.get(context);
    return Scaffold(
      drawer: const DrawerWidget(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              if (state is ErrorGetDataServiceAccState) {
                print("objectobjectobject$homeState");
                if (homeState is SuccessInitialStatusHomeState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (LocaleKeys.itSeemsYoureNotConnectedToTheInternet.tr() ==
                    state.error) {
                  return const HomeScreen();
                }
                return Column(
                  children: [
                    const AppBarHeader(),
                    Expanded(
                      child: CustomError(
                        error: state.error,
                        onPressed: () {
                          MainCubit.get(context).getDataServiceAcc();
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is SuccessGetDataServiceAccState) {
                return mainCubit.getWidgetMain(
                    state.dataServiceAccModel, context);
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}

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
    return Scaffold(
      drawer: const DrawerWidget(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return _buildContent(context, state, homeState);
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, MainState state, HomeState homeState) {
    final mainCubit = MainCubit.get(context);

    if (state is ErrorGetDataServiceAccState) {
      return _buildErrorState(context, state, homeState);
    } else if (state is SuccessGetDataServiceAccState) {
      return mainCubit.getWidgetMain(state.dataServiceAccModel, context);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildErrorState(BuildContext context,
      ErrorGetDataServiceAccState state, HomeState homeState) {
    if (homeState is SuccessInitialStatusHomeState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error == LocaleKeys.itSeemsYoureNotConnectedToTheInternet.tr()) {
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
  }
}

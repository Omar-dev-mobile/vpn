import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/locator.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: const AppBarHeader(),
      body: BlocConsumer<MainCubit, MainState>(
        bloc: locator<MainCubit>()..getDataServiceAcc(),
        listener: (context, state) {},
        builder: (context, state) {
          var mainCubit = MainCubit.get(context);
          if (state is ErrorGetDataServiceAccState) {
            return Center(
              child: CommonTextWidget(
                text: state.error.toString(),
                size: 18,
                color: Theme.of(context).textTheme.displaySmall!.color,
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is SuccessGetDataServiceAccState) {
            return mainCubit.getWidgetMain(state.dataServiceAccModel, context);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

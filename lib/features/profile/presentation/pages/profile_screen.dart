import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/custom_error.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/profile/presentation/widgets/profile_with_sub.dart';
import 'package:vpn/features/profile/presentation/widgets/profile_without_sub.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mainCubit = MainCubit.get(context);
    return Scaffold(
      drawer: mainCubit.errorMessage.isNotEmpty ? const DrawerWidget() : null,
      appBar: mainCubit.errorMessage.isNotEmpty ? const AppBarHeader() : null,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileErrorState) {
            return CustomError(
              error: state.error,
            );
          } else if (state is ProfileSuccessState) {
            final profileModel = state.profileModel;
            return mainCubit.errorMessage.isEmpty
                ? ProfileWithSub(profileModel: profileModel)
                : ProfileWithoutSub(profileModel: profileModel);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

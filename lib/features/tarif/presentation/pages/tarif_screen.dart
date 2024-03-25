import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/shared/components/builder_bloc.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_tarif_widget.dart';
import 'package:vpn/locator.dart';

@RoutePage()
class TarifScreen extends StatelessWidget {
  const TarifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      body: BlocProvider(
        create: (context) => TarifCubit(locator())..getTrials(),
        child: BlocBuilder<PurchasesCubit, PurchasesStatus>(
          builder: (context, state) {
            // .tarifs.forEach((element) {
            //   // print(element.);
            // });

            return Column(
              children: [
                const AppBarHeader(),
                screenUtil.setHeight(33).ph,
                Expanded(
                  child: BlocConsumer<TarifCubit, TarifState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return BuilderBloc<TarifSuccessState, TarifErrorState>(
                        state: state,
                        child: Builder(
                          builder: (context) {
                            var tarifs =
                                (state as TarifSuccessState).tarifModel;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    text: 'Tarif',
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    size: screenUtil.setSp(35),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var traif = tarifs.workStatus
                                                  ?.tarifList?[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  PurchasesCubit.get(context)
                                                      .buyTarif();
                                                },
                                                child: CardTarifWidget(
                                                  prise: traif
                                                          ?.tarifCostActivation ??
                                                      "",
                                                  index: index,
                                                  plan: traif?.tarifName ?? "",
                                                  day:
                                                      '${traif?.tarifDays ?? ""} days',
                                                  percent:
                                                      index == 0 ? 0.7 : null,
                                                ),
                                              );
                                            },
                                            itemCount: tarifs.workStatus
                                                    ?.tarifList?.length ??
                                                0,
                                            shrinkWrap: true,
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    20.ph,
                                          ),
                                          60.ph,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

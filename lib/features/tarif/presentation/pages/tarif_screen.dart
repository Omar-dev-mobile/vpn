import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_error.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/features/tarif/presentation/widgets/custom_page_view.dart';
import 'package:vpn/features/tarif/presentation/widgets/page_view_tarif.dart';
import 'package:vpn/features/tarif/presentation/widgets/service_and_privacy_row.dart';
import 'package:vpn/features/tarif/presentation/widgets/text_container.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';

@RoutePage()
class TarifScreen extends StatefulWidget {
  const TarifScreen({super.key});

  @override
  State<TarifScreen> createState() => _TarifScreenState();
}

class _TarifScreenState extends State<TarifScreen> {
  @override
  void dispose() {
    locator<PurchasesCubit>().closeSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: BlocConsumer<PurchasesCubit, PurchasesStatus>(
        listener: (context, statePurchases) {
          var purchasesCubit = PurchasesCubit.get(context);
          if (statePurchases is ErrorPurchaseState) {
            CustomSnackBar.badSnackBar(context, statePurchases.error);
          } else if (statePurchases is ErrorOriginalTransactionPurchaseState) {
            CustomSnackBar.badSnackBar(context, statePurchases.error);
            purchasesCubit.goToHome(context);
          } else if (statePurchases is SuccessPurchaseState) {
            purchasesCubit.goToHome(context);
            CustomSnackBar.goodSnackBar(
              context,
              LocaleKeys.successfullyPurchased.tr(),
            );
          }
        },
        builder: (context, statePurchases) {
          var tarifCubit = TarifCubit.get(context);
          return RefreshIndicator(
            onRefresh: () async {
              await tarifCubit.getTrials(isRefresh: true);
            },
            child: BlocBuilder<TarifCubit, TarifState>(
              builder: (context, state) {
                var purchasesCubit = PurchasesCubit.get(context);
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppBarHeader(
                          isClose: true,
                        ),
                        screenUtil.setHeight(33).ph,
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (state is TarifLoadingState ||
                                  state is LoadingInitStoreInfoState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is TarifErrorState) {
                                return CustomError(
                                  error: state.error,
                                  onPressed: () {
                                    tarifCubit.getTrials();
                                  },
                                );
                              }
                              if (statePurchases is EndInitStoreInfoState &&
                                  purchasesCubit.tarifs.isEmpty) {
                                return CustomError(
                                  error: LocaleKeys
                                      .somethingWentWrongPleaseTryAgain
                                      .tr(),
                                  onPressed: () {
                                    tarifCubit.getTrials();
                                  },
                                );
                              }
                              var tarifs =
                                  (state as TarifSuccessState).tarifModel;
                              var traif = tarifs.workStatus
                                  ?.tarifList?[purchasesCubit.indexTariff];

                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const CustomPageView(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 20),
                                      child: CommonTextWidget(
                                        text:
                                            LocaleKeys.VPNLineSubscription.tr(),
                                        fontWeight: FontWeight.w500,
                                        size: 28,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.color,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenUtil.setHeight(300),
                                      child: Stack(
                                        children: [
                                          const Align(
                                              alignment: Alignment.bottomCenter,
                                              child: TextContainer()),
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: PageViewTariff(
                                              statePurchases: statePurchases,
                                              tarifs: tarifs,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      child: Center(
                                          child: CommonTextWidget(
                                        text: LocaleKeys
                                            .youCanManageAndAancelSubscription
                                            .tr(),
                                        size: 12,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.color,
                                      )),
                                    ),
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 32),
                                        child: ServiceAndPrivacyRow(),
                                      ),
                                    ),
                                    50.ph
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    if (statePurchases is LoadingPendingPurchaseState)
                      ModalBarrier(
                        dismissible: false,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    if (statePurchases is LoadingPendingPurchaseState)
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonTextWidget(
                                  text: LocaleKeys.waitingForAPurchase.tr(),
                                  color: kBluishGray,
                                  fontWeight: FontWeight.w500,
                                  size: 25,
                                ),
                                20.ph,
                                const CircularProgressIndicator(),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

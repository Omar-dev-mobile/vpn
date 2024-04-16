import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_tarif_widget.dart';
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
    if (mounted) {
      var purchasesCubit = locator<PurchasesCubit>();
      if (purchasesCubit.subscription != null) {
        purchasesCubit.subscription!.cancel();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mainCubit = MainCubit.get(context);
    return Scaffold(
      drawer: const DrawerWidget(),
      body: BlocProvider(
        create: (context) => TarifCubit(locator(), locator())..getTrials(),
        child: BlocBuilder<TarifCubit, TarifState>(
          builder: (context, state) {
            return BlocConsumer<PurchasesCubit, PurchasesStatus>(
              listener: (context, statePurchases) {
                if (statePurchases is ErrorPurchaseState) {
                  CustomSnackBar.badSnackBar(context, statePurchases.error);
                } else if (statePurchases is SuccessPurchaseState) {
                  CustomSnackBar.goodSnackBar(
                    context,
                    LocaleKeys.successfullyPurchased.tr(),
                  );
                  mainCubit.getDataServiceAcc(isUpdateAcc: true);
                  context.pushRoute(const MainRoute());
                }
              },
              builder: (context, statePurchases) {
                var tarifCubit = TarifCubit.get(context);
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppBarHeader(),
                        screenUtil.setHeight(33).ph,
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CommonTextWidget(
                            text: LocaleKeys.plans.tr(),
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                            size: screenUtil.setSp(35),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              var purchasesCubit = PurchasesCubit.get(context);
                              if (state is TarifLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is TarifErrorState) {
                                return CommonTextWidget(text: state.error);
                              }
                              var tarifs =
                                  (state as TarifSuccessState).tarifModel;
                              var userInfo =
                                  tarifCubit.vpnInfo?.userInfo?.tarifInfo;
                              bool tarifUser = tarifCubit.vpnInfo != null &&
                                  userInfo != null &&
                                  userInfo.productId != null &&
                                  mainCubit.errorMessage.isEmpty;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                if (tarifUser && index == 0) {
                                                  return CardTarifWidget(
                                                    prise: userInfo
                                                            .tarifCostActivation ??
                                                        "",
                                                    index: 0,
                                                    plan: userInfo.tarifName ??
                                                        "",
                                                    day:
                                                        '${userInfo.tarifDays ?? ""} ${LocaleKeys.days.tr()}',
                                                    percent: getPercent(
                                                        tarifCubit
                                                            .vpnInfo
                                                            ?.userInfo
                                                            ?.vpnTimeExpire,
                                                        userInfo.tarifName ??
                                                            ""),
                                                  );
                                                }
                                                var traif = tarifs
                                                        .workStatus?.tarifList?[
                                                    index -
                                                        (tarifUser ? 1 : 0)];
                                                if (userInfo?.productId ==
                                                    traif?.tarifBuy) {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (statePurchases
                                                        is! LoadingPendingPurchaseState) {
                                                      purchasesCubit.buyTarif(
                                                          traif!.tarifBuy ??
                                                              "");
                                                    }
                                                  },
                                                  child: CardTarifWidget(
                                                    prise: traif
                                                            ?.tarifCostActivation ??
                                                        "",
                                                    index: index,
                                                    plan:
                                                        traif?.tarifName ?? "",
                                                    day:
                                                        '${traif?.tarifDays ?? ""} ${LocaleKeys.days.tr()}',
                                                  ),
                                                );
                                              },
                                              itemCount: ((tarifs.workStatus
                                                          ?.tarifList?.length ??
                                                      0) +
                                                  (tarifUser ? 1 : 0)),
                                              shrinkWrap: true,
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
                        ),
                      ],
                    ),
                    if (statePurchases is LoadingPendingPurchaseState)
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_tarif_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class PageViewTariff extends StatefulWidget {
  const PageViewTariff(
      {super.key, required this.statePurchases, required this.tarifs});
  final PurchasesStatus statePurchases;
  final TarifModel tarifs;

  @override
  _ListTariffPageViewState createState() => _ListTariffPageViewState();
}

class _ListTariffPageViewState extends State<PageViewTariff> {
  final PageController _pageController =
      PageController(viewportFraction: 0.9, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    var tarifCubit = TarifCubit.get(context);
    var purchasesCubit = PurchasesCubit.get(context);
    var userInfo = tarifCubit.vpnInfo?.userInfo?.tarifInfo;
    bool tarifUser = tarifCubit.vpnInfo != null &&
        userInfo != null &&
        userInfo.productId != null &&
        MainCubit.get(context).errorMessage.isEmpty;

    return BlocBuilder<TarifCubit, TarifState>(
      builder: (context, state) {
        List<Widget> pages = [];
        if (tarifUser) {
          pages.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CardTarifWidget(
                prise: userInfo.tarifCostActivation ?? "",
                index: 0,
                productId: userInfo.productId ?? "",
                plan: userInfo.tarifName ?? "",
                tarifDays: userInfo.tarifName ?? "",
                day: getDaysRemainingText(calculateDaysLeft(
                    tarifCubit.vpnInfo?.userInfo?.vpnTimeExpire)),
                percent: getPercent(tarifCubit.vpnInfo?.userInfo?.vpnTimeExpire,
                    userInfo.productId ?? ""),
              ),
            ),
          );
        }

        for (var i = 0;
            i < (widget.tarifs.workStatus?.tarifList?.length ?? 0);
            i++) {
          var traif = widget.tarifs.workStatus?.tarifList?[i];
          if (userInfo?.productId == traif?.tarifBuy && tarifUser) {
            continue;
          }
          pages.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: CardTarifWidget(
                      prise: traif?.tarifCostActivation ?? "",
                      index: i,
                      productId: traif?.tarifBuy ?? "",
                      tarifDays: userInfo?.tarifName ?? "",
                      plan: traif?.tarifName ?? "",
                      day: '${traif?.tarifDays ?? ""} ${LocaleKeys.days.tr()}',
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.white.withOpacity(0.5),
                        highlightColor: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          if (widget.statePurchases
                              is! LoadingPendingPurchaseState) {
                            purchasesCubit.buyTarif(traif!.tarifBuy ?? "");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox(
          height: screenUtil.setHeight(200),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {});
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
        );
      },
    );
  }
}

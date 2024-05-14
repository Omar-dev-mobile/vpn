import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_tarif_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class ListTariff extends StatelessWidget {
  const ListTariff(
      {super.key, required this.statePurchases, required this.tarifs});
  final PurchasesStatus statePurchases;
  final TarifModel tarifs;
  @override
  Widget build(BuildContext context) {
    var tarifCubit = TarifCubit.get(context);
    var purchasesCubit = PurchasesCubit.get(context);
    var userInfo = tarifCubit.vpnInfo?.userInfo?.tarifInfo;
    bool tarifUser = tarifCubit.vpnInfo != null &&
        userInfo != null &&
        userInfo.productId != null &&
        MainCubit.get(context).errorMessage.isEmpty;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (tarifUser && index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CardTarifWidget(
              prise: userInfo.tarifCostActivation ?? "",
              index: 0,
              plan: userInfo.tarifName ?? "",
              tarifDays: userInfo.tarifName ?? "",
              day: getDaysRemainingText(calculateDaysLeft(
                  tarifCubit.vpnInfo?.userInfo?.vpnTimeExpire)),
              percent: getPercent(tarifCubit.vpnInfo?.userInfo?.vpnTimeExpire,
                  userInfo.productId ?? ""),
            ),
          );
        }
        var traif = tarifs.workStatus?.tarifList?[index - (tarifUser ? 1 : 0)];

        if (userInfo?.productId == traif?.tarifBuy && tarifUser) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: CardTarifWidget(
                  prise: traif?.tarifCostActivation ?? "",
                  index: index,
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
                      if (statePurchases is! LoadingPendingPurchaseState) {
                        purchasesCubit.buyTarif(traif!.tarifBuy ?? "");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount:
          ((tarifs.workStatus?.tarifList?.length ?? 0) + (tarifUser ? 1 : 0)),
      shrinkWrap: true,
    );
  }
}

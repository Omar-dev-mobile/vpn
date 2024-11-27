import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/features/tarif/presentation/widgets/small_card_tarif_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class ListViewTariff extends StatefulWidget {
  const ListViewTariff({
    super.key,
    required this.statePurchases,
    required this.tarifs,
  });

  final PurchasesStatus statePurchases;
  final TarifModel tarifs;

  @override
  _ListTariffState createState() => _ListTariffState();
}

class _ListTariffState extends State<ListViewTariff> {
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
        List<Widget> items = [];

        for (var i = 0;
            i < (widget.tarifs.workStatus?.tarifList?.length ?? 0);
            i++) {
          var traif = widget.tarifs.workStatus?.tarifList?[i];

          if (tarifUser &&
              (userInfo.productId == traif?.tarifBuy && tarifUser)) {
            items.insert(
              i,
              SmallCardTarifWidget(
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
            );
          } else {
            items.add(
              Stack(
                children: <Widget>[
                  Positioned(
                    child: SmallCardTarifWidget(
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
                          print("objectobjectobjectobject");
                          if (widget.statePurchases
                              is! LoadingPendingPurchaseState) {
                            purchasesCubit.buyTarif(traif?.tarifBuy ?? "");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }

        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return 10.ph;
          },
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index];
          },
        );
      },
    );
  }
}

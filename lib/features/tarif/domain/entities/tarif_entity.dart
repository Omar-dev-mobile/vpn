import 'package:vpn/features/tarif/data/models/tarif_model.dart';

class TarifEntity {
  TarifEntity({
    this.errorCode,
    this.workStatus,
    this.dateSave,
  });
  int? errorCode;
  WorkStatusModel? workStatus;
  DateTime? dateSave;
}

class WorkStatusEntity {
  WorkStatusEntity({
    this.udid,
    this.tarifList,
  });
  String? udid;
  List<TarifListModel>? tarifList;
}

class TarifListEntity {
  TarifListEntity({
    this.tarifId,
    this.tarifName,
    this.tarifDays,
    this.tarifCostActivation,
    this.tarifCostPerMb,
    this.tarifBuy,
  });
  String? tarifId;
  String? tarifName;
  String? tarifDays;
  String? tarifCostActivation;
  String? tarifCostPerMb;
  String? tarifBuy;
}

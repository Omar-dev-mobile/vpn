import 'package:vpn/features/tarif/data/models/tarif_model.dart';

class TarifEntity {
  TarifEntity({
    this.errorCode,
    this.workStatus,
  });
  int? errorCode;
  WorkStatusModel? workStatus;
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
  });
  String? tarifId;
  String? tarifName;
  String? tarifDays;
  String? tarifCostActivation;
  String? tarifCostPerMb;
}

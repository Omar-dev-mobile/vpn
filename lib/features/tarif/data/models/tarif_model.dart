import 'package:vpn/core/shared/components/date_utils_format.dart';
import 'package:vpn/features/tarif/domain/entities/tarif_entity.dart';

class TarifModel extends TarifEntity {
  TarifModel({
    super.errorCode,
    super.workStatus,
  });

  TarifModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    workStatus = WorkStatusModel.fromJson(json['work_status']);
    dateSave = json['dateSave'] == null
        ? null
        : DateUtilsFormat.dateFormatWithTryParse(json['dateSave']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['dateSave'] = dateSave.toString();
    data['work_status'] = workStatus?.toJson();
    return data;
  }
}

class WorkStatusModel extends WorkStatusEntity {
  WorkStatusModel({
    super.udid,
    super.tarifList,
  });

  WorkStatusModel.fromJson(Map<String, dynamic> json) {
    udid = json['udid'];
    tarifList = json['tarif_list'] != null
        ? List.from(json['tarif_list'])
            .map((e) => TarifListModel.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['udid'] = udid;
    data['tarif_list'] = tarifList?.map((e) => e.toJson()).toList();
    return data;
  }
}

class TarifListModel extends TarifListEntity {
  TarifListModel({
    super.tarifId,
    super.tarifName,
    super.tarifDays,
    super.tarifCostActivation,
    super.tarifCostPerMb,
    super.tarifBuy,
  });
  TarifListModel.fromJson(Map<String, dynamic> json) {
    tarifId = json['tarif_id'];
    tarifName = json['tarif_name'];
    tarifDays = json['tarif_days'];
    tarifCostActivation = json['tarif_cost_activation'];
    tarifBuy = json['tarif_buy'];
    tarifCostPerMb = json['tarif_cost_per_mb'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tarif_id'] = tarifId;
    data['tarif_name'] = tarifName;
    data['tarif_buy'] = tarifBuy;
    data['tarif_days'] = tarifDays;
    data['tarif_cost_activation'] = tarifCostActivation;
    data['tarif_cost_per_mb'] = tarifCostPerMb;
    return data;
  }
}

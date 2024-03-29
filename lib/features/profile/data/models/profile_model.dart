import 'package:vpn/core/constants.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';

class ProfileModel {
  ProfileModel({
    this.errorCode,
    this.workStatus,
  });
  int? errorCode;
  WorkStatus? workStatus;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    workStatus = json['work_status'] != null
        ? WorkStatus.fromJson(json['work_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['work_status'] = workStatus?.toJson();
    return data;
  }
}

class WorkStatus {
  WorkStatus({
    this.udid,
    this.userInfo,
  });
  String? udid;
  UserInfoModel? userInfo;

  WorkStatus.fromJson(Map<String, dynamic> json) {
    udid = json['udid'];
    userInfo = json['user_info'] != null
        ? UserInfoModel.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['udid'] = udid;
    data['user_info'] = userInfo?.toJson();
    return data;
  }
}

class TarifInfo {
  TarifInfo({
    this.tarifId,
    this.tarifName,
    this.tarifCostActivation,
    this.tarifCostPerMb,
    this.tarifDays,
  });
  String? tarifId;
  String? tarifName;
  String? tarifCostActivation;
  String? tarifCostPerMb;
  String? tarifDays;
  String? productId;

  TarifInfo.fromJson(Map<String, dynamic> json) {
    tarifId = json['tarif_id'];
    tarifName = json['tarif_name'];
    tarifCostActivation = json['tarif_cost_activation'];
    tarifCostPerMb = json['tarif_cost_per_mb'];
    tarifDays = json['tarif_days'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tarif_id'] = tarifId;
    data['tarif_name'] = tarifName;
    data['tarif_cost_activation'] = tarifCostActivation;
    data['tarif_cost_per_mb'] = tarifCostPerMb;
    data['tarif_days'] = tarifDays;
    data['product_id'] = productId;
    return data;
  }
}

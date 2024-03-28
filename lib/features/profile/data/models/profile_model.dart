import 'package:vpn/core/constants.dart';
import 'package:vpn/core/shared/extensions/extension.dart';

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
  UserInfo? userInfo;

  WorkStatus.fromJson(Map<String, dynamic> json) {
    udid = json['udid'];
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['udid'] = udid;
    data['user_info'] = userInfo?.toJson();
    return data;
  }
}

class UserInfo {
  UserInfo({
    this.login,
    this.id,
    this.timeadd,
    this.email,
    this.userApiKey,
    this.flValidEmail,
    this.dateLastLogin,
    this.balance,
    this.flBlock,
    this.vpnTimeExpire,
    this.vpnTimeExpireUnixtime,
    this.tarifInfo,
  });
  String? login;
  String? id;
  String? timeadd;
  String? email;
  String? userApiKey;
  String? flValidEmail;
  String? dateLastLogin;
  String? balance;
  String? flBlock;
  DateTime? vpnTimeExpire;
  String? vpnTimeExpireUnixtime;
  TarifInfo? tarifInfo;
  double? percent;
  UserInfo.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    timeadd = json['timeadd'];
    email = json['email'];
    userApiKey = json['user_api_key'];
    flValidEmail = json['fl_valid_email'];
    dateLastLogin = json['date_last_login'];
    balance = json['balance'];
    flBlock = json['fl_block'];
    vpnTimeExpire = json['vpn_time_expire'] != null
        ? DateTime.tryParse(json['vpn_time_expire'])
        : null;
    vpnTimeExpireUnixtime = json['vpn_time_expire_unixtime'];
    tarifInfo = json['tarif_info'] != null
        ? TarifInfo.fromJson(json['tarif_info'])
        : null;
    percent = getPercent(vpnTimeExpire, tarifInfo?.tarifName ?? "");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['timeadd'] = timeadd;
    data['email'] = email;
    data['user_api_key'] = userApiKey;
    data['fl_valid_email'] = flValidEmail;
    data['date_last_login'] = dateLastLogin;
    data['balance'] = balance;
    data['fl_block'] = flBlock;
    data['vpn_time_expire'] = vpnTimeExpire;
    data['vpn_time_expire_unixtime'] = vpnTimeExpireUnixtime;
    data['tarif_info'] = tarifInfo?.toJson();
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

  TarifInfo.fromJson(Map<String, dynamic> json) {
    tarifId = json['tarif_id'];
    tarifName = json['tarif_name'];
    tarifCostActivation = json['tarif_cost_activation'];
    tarifCostPerMb = json['tarif_cost_per_mb'];
    tarifDays = json['tarif_days'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tarif_id'] = tarifId;
    data['tarif_name'] = tarifName;
    data['tarif_cost_activation'] = tarifCostActivation;
    data['tarif_cost_per_mb'] = tarifCostPerMb;
    data['tarif_days'] = tarifDays;
    return data;
  }
}

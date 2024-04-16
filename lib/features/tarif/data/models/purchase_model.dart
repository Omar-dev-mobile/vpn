class PurchaseModel {
  PurchaseModel({
    this.errorCode,
    this.workStatus,
  });
  int? errorCode;
  WorkStatus? workStatus;
  bool inProgress = false;
// "work_status":{“result”:“ок”}}
  PurchaseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['work_status']['result'] != null) {
      inProgress = true;
    }
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
    this.userInfo,
  });
  UserInfo? userInfo;

  WorkStatus.fromJson(Map<String, dynamic> json) {
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_info'] = userInfo?.toJson();
    return data;
  }
}

class UserInfo {
  UserInfo({
    this.login,
    this.userApiKey,
    this.typeLogin,
    this.timeadd,
    this.email,
    this.dateLastLogin,
    this.flBlock,
    this.vpnTimeExpire,
    this.vpnTimeExpireUnixtime,
    this.clientDateCreate,
    this.clientDateCreateUnixtime,
    this.tarifInfo,
  });
  String? login;
  String? userApiKey;
  String? typeLogin;
  String? timeadd;
  String? email;
  String? dateLastLogin;
  String? flBlock;
  String? vpnTimeExpire;
  String? vpnTimeExpireUnixtime;
  String? clientDateCreate;
  String? clientDateCreateUnixtime;
  TarifInfo? tarifInfo;

  UserInfo.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    userApiKey = json['user_api_key'];
    typeLogin = json['type_login'];
    timeadd = json['timeadd'];
    email = json['email'];
    dateLastLogin = json['date_last_login'];
    flBlock = json['fl_block'];
    vpnTimeExpire = json['vpn_time_expire'];
    vpnTimeExpireUnixtime = json['vpn_time_expire_unixtime'];
    clientDateCreate = json['client_date_create'];
    clientDateCreateUnixtime = json['client_date_create_unixtime'];
    tarifInfo = json['tarif_info'] != null
        ? TarifInfo.fromJson(json['tarif_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['user_api_key'] = userApiKey;
    data['type_login'] = typeLogin;
    data['timeadd'] = timeadd;
    data['email'] = email;
    data['date_last_login'] = dateLastLogin;
    data['fl_block'] = flBlock;
    data['vpn_time_expire'] = vpnTimeExpire;
    data['vpn_time_expire_unixtime'] = vpnTimeExpireUnixtime;
    data['client_date_create'] = clientDateCreate;
    data['client_date_create_unixtime'] = clientDateCreateUnixtime;
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
    this.productId,
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

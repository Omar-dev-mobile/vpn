import 'package:vpn/features/auth/data/models/user_model.dart';

class DataServiceAccModel {
  DataServiceAccModel({
    this.errorCode,
    this.workStatus,
  });
  int? errorCode;
  WorkStatusAcc? workStatus;

  DataServiceAccModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    workStatus = json['work_status'] != null
        ? WorkStatusAcc.fromJson(json['work_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['work_status'] = workStatus?.toJson();
    return data;
  }
}

class WorkStatusAcc {
  WorkStatusAcc({
    this.u,
    this.k,
    this.p,
    this.s,
    this.vpnInfo,
    this.errorMessage,
  });
  String? u;
  String? k;
  String? p;
  String? s;
  VpnInfo? vpnInfo;
  String? errorMessage;
  String? errorAction;
  UserInfoModel? userInfo;
  WorkStatusAcc.fromJson(Map<String, dynamic> json) {
    u = json['u'];
    k = json['k'];
    p = json['p'];
    s = json['s'];
    vpnInfo =
        json['vpn_info'] != null ? VpnInfo.fromJson(json['vpn_info']) : null;
    userInfo = json['user_info'] != null
        ? UserInfoModel.fromJson(json['user_info'])
        : null;
    errorMessage = json['error_message'];
    errorAction = json['error_action'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['u'] = u;
    data['k'] = k;
    data['p'] = p;
    data['s'] = s;
    data['vpn_info'] = vpnInfo?.toJson();
    data['user_info'] = userInfo?.toJson();
    data['error_message'] = errorMessage;
    data['error_action'] = errorAction;
    return data;
  }
}

class VpnInfo {
  VpnInfo({
    this.id,
    this.ip,
    this.countryName,
    this.supportProtocols,
    this.countryId,
    this.ping,
    this.name,
    this.vsip,
  });
  int? id;
  String? ip;
  String? countryName;
  String? supportProtocols;
  String? countryId;
  String? ping;
  String? name;
  String? vsip;

  VpnInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ip = json['ip'];
    countryName = json['country_name'];
    supportProtocols = json['support_protocols'];
    countryId = json['country_id'];
    ping = json['ping'];
    name = json['name'];
    vsip = json['vsip'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ip'] = ip;
    data['country_name'] = countryName;
    data['support_protocols'] = supportProtocols;
    data['country_id'] = countryId;
    data['ping'] = ping;
    data['name'] = name;
    data['vsip'] = vsip;
    return data;
  }
}

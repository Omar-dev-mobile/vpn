import 'package:vpn/core/constants.dart';
import 'package:vpn/features/auth/domain/entities/user_entity.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';

class UserModel extends UserEntity {
  UserModel({super.errorCode, super.workStatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    workStatus = UserWorkStatusModel.fromJson(json['work_status']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['work_status'] = workStatus?.toJson();
    return data;
  }
}

class UserWorkStatusModel extends UserWorkStatus {
  UserWorkStatusModel({super.udid, super.userInfo});
  UserWorkStatusModel.fromJson(Map<String, dynamic> json) {
    udid = json['udid'];
    userInfo = UserInfoModel.fromJson(json['user_info']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['udid'] = udid;
    data['user_info'] = userInfo?.toJson();
    return data;
  }
}

class UserInfoModel extends UserInfo {
  UserInfoModel({
    super.login,
    super.userApiKey,
    super.typeLogin,
    super.id,
    super.timeadd,
    super.email,
    super.flValidEmail,
    super.dateLastLogin,
    super.balance,
    super.flBlock,
    super.vpnTimeExpire,
    super.vpnTimeExpireUnixtime,
    super.clientDateCreate,
    super.clientDateCreateUnixtime,
    super.tarifInfo,
    super.percent,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    userApiKey = json['user_api_key'];
    typeLogin = json['type_login'];
    id = json['id'];
    timeadd = json['timeadd'];
    email = json['email'];
    flValidEmail = json['fl_valid_email'];
    dateLastLogin = json['date_last_login'];
    balance = json['balance'];
    flBlock = json['fl_block'];
    vpnTimeExpire = json['vpn_time_expire'] != null
        ? DateTime.tryParse(json['vpn_time_expire'])
        : null;
    vpnTimeExpireUnixtime = json['vpn_time_expire_unixtime'];
    clientDateCreate = json['client_date_create'];
    clientDateCreateUnixtime = json['client_date_create_unixtime'];
    tarifInfo = TarifInfo.fromJson(json['tarif_info']);
    percent = getPercent(vpnTimeExpire, tarifInfo?.tarifName ?? "");
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['user_api_key'] = userApiKey;
    data['type_login'] = typeLogin;
    data['id'] = id;
    data['timeadd'] = timeadd;
    data['email'] = email;
    data['fl_valid_email'] = flValidEmail;
    data['date_last_login'] = dateLastLogin;
    data['balance'] = balance;
    data['fl_block'] = flBlock;
    data['vpn_time_expire'] = vpnTimeExpire;
    data['vpn_time_expire_unixtime'] = vpnTimeExpireUnixtime;
    data['client_date_create'] = clientDateCreate;
    data['client_date_create_unixtime'] = clientDateCreateUnixtime;
    data['tarif_info'] = tarifInfo?.toJson();
    return data;
  }
}

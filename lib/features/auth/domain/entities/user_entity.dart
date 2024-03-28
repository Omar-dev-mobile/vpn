import 'package:vpn/features/auth/data/models/user_model.dart';

class UserEntity {
  UserEntity({
    this.errorCode,
    this.workStatus,
  });
  int? errorCode;
  UserWorkStatusModel? workStatus;
}

class UserWorkStatus {
  UserWorkStatus({
    this.udid,
    this.userInfo,
  });
  String? udid;
  UserInfoModel? userInfo;
}

class UserInfo {
  UserInfo({
    this.login,
    this.userApiKey,
    this.typeLogin,
    this.id,
    this.timeadd,
    this.email,
    this.flValidEmail,
    this.dateLastLogin,
    this.balance,
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
  String? id;
  String? timeadd;
  String? email;
  String? flValidEmail;
  String? dateLastLogin;
  String? balance;
  String? flBlock;
  DateTime? vpnTimeExpire;
  String? vpnTimeExpireUnixtime;
  String? clientDateCreate;
  String? clientDateCreateUnixtime;
  TarifInfoModel? tarifInfo;
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
}

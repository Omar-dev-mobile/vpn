import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';

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
    this.percent,
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
  TarifInfo? tarifInfo;
  double? percent;
}

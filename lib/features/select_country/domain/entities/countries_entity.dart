import 'package:vpn/features/select_country/data/models/countries_model.dart';

class CountriesEntity {
  CountriesEntity({
    this.errorCode,
    this.workStatus,
  });
  int? errorCode;
  WorkStatusCountriesModel? workStatus;
  DateTime? dateSave;
}

class WorkStatusCountriesEntity {
  WorkStatusCountriesEntity({
    this.ver,
    this.vpnList,
  });
  dynamic ver;
  List<VpnList>? vpnList;
}

class VpnList {
  VpnList({
    this.id,
    this.ip,
    this.countryName,
    this.countryId,
    this.ping,
    this.name,
  });
  int? id;
  String? ip;
  String? countryName;
  String? countryId;
  String? ping;
  String? name;

  VpnList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ip = json['ip'];
    countryName = json['country_name'];
    countryId = json['country_id'];
    ping = json['ping'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ip'] = ip;
    data['country_name'] = countryName;
    data['country_id'] = countryId;
    data['ping'] = ping;
    data['name'] = name;
    return data;
  }
}

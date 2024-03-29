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
  List<VpnListModel>? vpnList;
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
}

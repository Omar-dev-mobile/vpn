import 'package:vpn/core/shared/components/date_utils_format.dart';
import 'package:vpn/features/select_country/domain/entities/countries_entity.dart';

class CountriesModel extends CountriesEntity {
  CountriesModel({
    super.errorCode,
    super.workStatus,
  });

  CountriesModel.fromJson(Map<String, dynamic> json) {
    print('fromJson${json['dateSave']}');
    errorCode = json['error_code'];
    dateSave = DateUtilsFormat.dateFormatWithTryParse(json['dateSave']);
    workStatus = WorkStatusCountriesModel.fromJson(json['work_status']);
  }

  Map<String, dynamic> toJson() {
    print('toJson$dateSave');
    final data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['work_status'] = workStatus?.toJson();
    data['dateSave'] = dateSave.toString();
    return data;
  }
}

class WorkStatusCountriesModel extends WorkStatusCountriesEntity {
  WorkStatusCountriesModel({
    super.ver,
    super.vpnList,
  });
  WorkStatusCountriesModel.fromJson(Map<String, dynamic> json) {
    ver = json['ver'];
    vpnList =
        List.from(json['vpn_list']).map((e) => VpnList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ver'] = ver;
    data['vpn_list'] = vpnList?.map((e) => e.toJson()).toList();
    return data;
  }
}

class VpnListModel extends VpnList {
  VpnListModel({
    super.id,
    super.ip,
    super.countryName,
    super.countryId,
    super.ping,
    super.name,
  });

  VpnListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ip = json['ip'];
    countryName = json['country_name'];
    countryId = json['country_id'];
    ping = json['ping'];
    name = json['name'];
  }

  @override
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

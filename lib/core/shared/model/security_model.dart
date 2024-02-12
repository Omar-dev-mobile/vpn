class SecurityModel {
  SecurityModel({
    this.oper,
    this.udid,
    this.rnd,
    this.pmk,
    this.signature,
  });
  String? oper;
  String? udid;
  String? rnd;
  String? pmk;
  String? signature;
  String? workStatus;

  SecurityModel.fromJson(Map<String, dynamic> json) {
    oper = json['oper'];
    udid = json['udid'];
    rnd = json['rnd'];
    pmk = json['pmk'];
    signature = json['signature'];
    workStatus = json['work_status'];
  }

  Map<String, dynamic> toJsonInit() {
    final data = <String, dynamic>{};
    data['oper'] = oper;
    data['udid'] = udid;
    data['rnd'] = rnd;
    data['pmk'] = pmk;
    data['signature'] = signature;
    data['work_status'] = workStatus;
    return data;
  }

  Map<String, dynamic> toJsonLogin() {
    final data = <String, dynamic>{};
    data['oper'] = oper;
    data['udid'] = udid;
    data['rnd'] = rnd;
    data['signature'] = signature;
    return data;
  }
}

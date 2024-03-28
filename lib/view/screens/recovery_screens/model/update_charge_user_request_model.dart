class UpdateChargeUserRequestModel {
  int? paid;
  int? requestId;

  UpdateChargeUserRequestModel({this.paid, this.requestId});

  UpdateChargeUserRequestModel.fromJson(Map<String, dynamic> json) {
    paid = json['paid'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paid'] = this.paid;
    data['request_id'] = this.requestId;
    return data;
  }
}

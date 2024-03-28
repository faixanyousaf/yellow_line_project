class ChargeUserResponceModel {
  Data? data;

  ChargeUserResponceModel({this.data});

  ChargeUserResponceModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic amount;
  dynamic plateNumber;
  dynamic userId;
  String? piId;
  String? clientSecret;
  dynamic paid;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
        this.amount,
        this.plateNumber,
        this.userId,
        this.piId,
        this.clientSecret,
        this.paid,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    plateNumber = json['plate_number'];
    userId = json['user_id'];
    piId = json['pi_id'];
    clientSecret = json['client_secret'];
    paid = json['paid'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['plate_number'] = this.plateNumber;
    data['user_id'] = this.userId;
    data['pi_id'] = this.piId;
    data['client_secret'] = this.clientSecret;
    data['paid'] = this.paid;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

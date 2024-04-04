class ChargeUserResponceModel {
  String? piId;
  String? clientSecret;
  Data? data;

  ChargeUserResponceModel({this.piId, this.clientSecret, this.data});

  ChargeUserResponceModel.fromJson(Map<String, dynamic> json) {
    piId = json['pi_id'];
    clientSecret = json['client_secret'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pi_id'] = this.piId;
    data['client_secret'] = this.clientSecret;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic amount;
  dynamic plateNumber;
  dynamic pickUpLat;
  dynamic pickUpLong;
  dynamic dropLat;
  dynamic dropLong;
  dynamic userId;
  dynamic updatedAt;
  dynamic createdAt;

  Data(
      {this.id,
        this.amount,
        this.plateNumber,
        this.pickUpLat,
        this.pickUpLong,
        this.dropLat,
        this.dropLong,
        this.userId,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    plateNumber = json['plate_number'];
    pickUpLat = json['pick_up_lat'];
    pickUpLong = json['pick_up_long'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    userId = json['user_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['plate_number'] = this.plateNumber;
    data['pick_up_lat'] = this.pickUpLat;
    data['pick_up_long'] = this.pickUpLong;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    data['user_id'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class ChargeUserRequestModel {
  int? amount;
  int? plateNumber;
  int? userId;

  ChargeUserRequestModel({this.amount, this.plateNumber, this.userId});

  ChargeUserRequestModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    plateNumber = json['plate_number'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['plate_number'] = this.plateNumber;
    data['user_id'] = this.userId;
    return data;
  }
}

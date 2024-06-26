class ChargeUserRequestModel {
  String? amount;
  String? plateNumber;
  String? pickUpLat;
  String? pickUpLong;
  String? dropLat;
  String? dropLong;
  String? userId;
  String? pickupName;
  String? dropName;
  String? recovery_type;

  ChargeUserRequestModel(
      {this.amount,
        this.plateNumber,
        this.pickUpLat,
        this.pickUpLong,
        this.dropLat,
        this.dropLong,
        this.userId,
        this.pickupName,
        this.recovery_type,
        this.dropName});

  ChargeUserRequestModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    plateNumber = json['plate_number'];
    pickUpLat = json['pick_up_lat'];
    pickUpLong = json['pick_up_long'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    userId = json['user_id'];
    pickupName = json['pickup_name'];
    dropName = json['drop_name'];
    recovery_type = json['recovery_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['plate_number'] = this.plateNumber;
    data['pick_up_lat'] = this.pickUpLat;
    data['pick_up_long'] = this.pickUpLong;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    data['user_id'] = this.userId;
    data['pickup_name'] = this.pickupName;
    data['drop_name'] = this.dropName;
    data['recovery_type'] = this.recovery_type;
    return data;
  }
}

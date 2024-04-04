class ViewRequestModel {
  int? id;
  int? userId;
  int? amount;
  String? plateNumber;
  int? status;
  dynamic pickUpLat;
  dynamic pickUpLong;
  dynamic pickupName;
  dynamic dropName;
  dynamic dropLat;
  dynamic dropLong;
  dynamic driverId;
  dynamic driverName;
  dynamic driverMobile;
  dynamic driverLat;
  dynamic driverLong;
  dynamic time;
  dynamic distance;
  dynamic createdAt;
  dynamic updatedAt;

  ViewRequestModel(
      {this.id,
        this.userId,
        this.amount,
        this.plateNumber,
        this.status,
        this.pickUpLat,
        this.pickUpLong,
        this.pickupName,
        this.dropName,
        this.dropLat,
        this.dropLong,
        this.driverId,
        this.driverName,
        this.driverMobile,
        this.driverLat,
        this.driverLong,
        this.time,
        this.distance,
        this.createdAt,
        this.updatedAt});

  ViewRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    plateNumber = json['plate_number'];
    status = json['status'];
    pickUpLat = json['pick_up_lat'];
    pickUpLong = json['pick_up_long'];
    pickupName = json['pickup_name'];
    dropName = json['drop_name'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    driverMobile = json['driver_mobile'];
    driverLat = json['driver_lat'];
    driverLong = json['driver_long'];
    time = json['time'];
    distance = json['distance'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['plate_number'] = this.plateNumber;
    data['status'] = this.status;
    data['pick_up_lat'] = this.pickUpLat;
    data['pick_up_long'] = this.pickUpLong;
    data['pickup_name'] = this.pickupName;
    data['drop_name'] = this.dropName;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['driver_mobile'] = this.driverMobile;
    data['driver_lat'] = this.driverLat;
    data['driver_long'] = this.driverLong;
    data['time'] = this.time;
    data['distance'] = this.distance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

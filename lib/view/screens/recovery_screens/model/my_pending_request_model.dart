class PendingRequestModel {
  dynamic id;
  dynamic customerId;
  dynamic plateNumber;
  dynamic pickUpLat;
  dynamic pickUpLong;
  dynamic pickupName;
  dynamic dropLat;
  dynamic dropLong;
  dynamic dropName;
  dynamic amount;
  dynamic distance;
  dynamic time;
  dynamic status;
  dynamic driverLat;
  dynamic acceptedbydriver;
  dynamic driverLong;
  dynamic driverId;
  dynamic driverName;
  dynamic driverDialCode;
  dynamic driverMobile;
  dynamic companyName;
  dynamic companyType;
  dynamic companyEmail;
  dynamic reasonToReject;
  dynamic customerEmail;
  dynamic driverEmail;
  dynamic isDriverVerified;
  dynamic isDriverEmailVerified;
  dynamic vehicleAssignedToDriver;
  dynamic companyLogo;
  dynamic createdAt;
  dynamic updatedAt;

  PendingRequestModel(
      {this.id,
        this.customerId,
        this.plateNumber,
        this.pickUpLat,
        this.pickUpLong,
        this.pickupName,
        this.dropLat,
        this.dropLong,
        this.dropName,
        this.amount,
        this.distance,
        this.time,
        this.status,
        this.driverLat,
        this.acceptedbydriver,
        this.driverLong,
        this.driverId,
        this.driverName,
        this.driverDialCode,
        this.driverMobile,
        this.companyName,
        this.companyType,
        this.companyEmail,
        this.reasonToReject,
        this.customerEmail,
        this.driverEmail,
        this.isDriverVerified,
        this.isDriverEmailVerified,
        this.vehicleAssignedToDriver,
        this.companyLogo,
        this.createdAt,
        this.updatedAt});

  PendingRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    plateNumber = json['plate_number'];
    pickUpLat = json['pick_up_lat'];
    pickUpLong = json['pick_up_long'];
    pickupName = json['pickup_name'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    dropName = json['drop_name'];
    amount = json['amount'];
    distance = json['distance'];
    time = json['time'];
    status = json['status'];
    driverLat = json['driver_lat'];
    acceptedbydriver = json['acceptedbydriver'];
    driverLong = json['driver_long'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    driverDialCode = json['driver_dial_code'];
    driverMobile = json['driver_mobile'];
    companyName = json['company_name'];
    companyType = json['company_type'];
    companyEmail = json['company_email'];
    reasonToReject = json['reason_to_reject'];
    customerEmail = json['customer_email'];
    driverEmail = json['driver_email'];
    isDriverVerified = json['is_driver_verified'];
    isDriverEmailVerified = json['is_driver_email_verified'];
    vehicleAssignedToDriver = json['vehicle_assigned_to_driver'];
    companyLogo = json['company_logo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['plate_number'] = this.plateNumber;
    data['pick_up_lat'] = this.pickUpLat;
    data['pick_up_long'] = this.pickUpLong;
    data['pickup_name'] = this.pickupName;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    data['drop_name'] = this.dropName;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['driver_lat'] = this.driverLat;
    data['acceptedbydriver'] = this.acceptedbydriver;
    data['driver_long'] = this.driverLong;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['driver_dial_code'] = this.driverDialCode;
    data['driver_mobile'] = this.driverMobile;
    data['company_name'] = this.companyName;
    data['company_type'] = this.companyType;
    data['company_email'] = this.companyEmail;
    data['reason_to_reject'] = this.reasonToReject;
    data['customer_email'] = this.customerEmail;
    data['driver_email'] = this.driverEmail;
    data['is_driver_verified'] = this.isDriverVerified;
    data['is_driver_email_verified'] = this.isDriverEmailVerified;
    data['vehicle_assigned_to_driver'] = this.vehicleAssignedToDriver;
    data['company_logo'] = this.companyLogo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

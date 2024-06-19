class ViewRequestModel {
  dynamic id;
  dynamic customerId;
  dynamic recoveryType;
  dynamic plateNumber;
  dynamic pickUpLat;
  dynamic pickUpLong;
  dynamic pickupName;
  dynamic dropName;
  dynamic dropLat;
  dynamic dropLong;
  dynamic amount;
  dynamic status;
  dynamic driverLat;
  dynamic acceptedbydriver;
  dynamic driverLong;
  dynamic driverId;
  dynamic driverName;
  dynamic driverDialCode;
  dynamic driverMobile;
  dynamic driverPlatNumber;
  dynamic averageRating;
  dynamic rated;
  dynamic companyName;
  dynamic companyType;
  dynamic companyDialCode;
  dynamic companyMobile;
  dynamic companyId;
  dynamic companyEmail;
  dynamic reasonToReject;
  dynamic customerEmail;
  dynamic customerName;
  dynamic customerDialCode;
  dynamic customerMobile;
  dynamic driverEmail;
  dynamic isDriverVerified;
  dynamic isDriverEmailVerified;
  dynamic vehicleAssignedToDriver;
  dynamic companyLogo;
  dynamic createdAt;
  dynamic updatedAt;

  ViewRequestModel(
      {this.id,
      this.customerId,
      this.recoveryType,
      this.plateNumber,
      this.pickUpLat,
      this.pickUpLong,
      this.pickupName,
      this.dropName,
      this.dropLat,
      this.dropLong,
      this.amount,
      this.status,
      this.driverLat,
      this.acceptedbydriver,
      this.driverLong,
      this.driverId,
      this.driverName,
      this.driverDialCode,
      this.driverMobile,
      this.driverPlatNumber,
      this.companyName,
      this.companyType,
      this.companyDialCode,
      this.companyMobile,
      this.companyId,
      this.companyEmail,
      this.reasonToReject,
      this.customerEmail,
      this.customerName,
      this.customerDialCode,
      this.customerMobile,
      this.driverEmail,
      this.isDriverVerified,
      this.isDriverEmailVerified,
      this.vehicleAssignedToDriver,
      this.companyLogo,
      this.createdAt,
      this.averageRating,
      this.rated,
      this.updatedAt});

  ViewRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    recoveryType = json['recovery_type'];
    plateNumber = json['plate_number'];
    pickUpLat = json['pick_up_lat'];
    pickUpLong = json['pick_up_long'];
    pickupName = json['pickup_name'];
    dropName = json['drop_name'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    amount = json['amount'];
    status = json['status'];
    driverLat = json['driver_lat'];
    acceptedbydriver = json['acceptedbydriver'];
    driverLong = json['driver_long'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    driverDialCode = json['driver_dial_code'];
    driverMobile = json['driver_mobile'];
    driverPlatNumber = json['driver_plat_number'];
    averageRating = json['averageRating'];
    rated = json['rated'];
    companyName = json['company_name'];
    companyType = json['company_type'];
    companyDialCode = json['company_dial_code'];
    companyMobile = json['company_mobile'];
    companyId = json['company_id'];
    companyEmail = json['company_email'];
    reasonToReject = json['reason_to_reject'];
    customerEmail = json['customer_email'];
    customerName = json['customer_name'];
    customerDialCode = json['customer_dial_code'];
    customerMobile = json['customer_mobile'];
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
    data['recovery_type'] = this.recoveryType;
    data['plate_number'] = this.plateNumber;
    data['pick_up_lat'] = this.pickUpLat;
    data['pick_up_long'] = this.pickUpLong;
    data['pickup_name'] = this.pickupName;
    data['drop_name'] = this.dropName;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['driver_lat'] = this.driverLat;
    data['acceptedbydriver'] = this.acceptedbydriver;
    data['driver_long'] = this.driverLong;
    data['averageRating'] = this.averageRating;
    data['rated'] = this.rated;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['driver_dial_code'] = this.driverDialCode;
    data['driver_mobile'] = this.driverMobile;
    data['driver_plat_number'] = this.driverPlatNumber;
    data['company_name'] = this.companyName;
    data['company_type'] = this.companyType;
    data['company_dial_code'] = this.companyDialCode;
    data['company_mobile'] = this.companyMobile;
    data['company_id'] = this.companyId;
    data['company_email'] = this.companyEmail;
    data['reason_to_reject'] = this.reasonToReject;
    data['customer_email'] = this.customerEmail;
    data['customer_name'] = this.customerName;
    data['customer_dial_code'] = this.customerDialCode;
    data['customer_mobile'] = this.customerMobile;
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

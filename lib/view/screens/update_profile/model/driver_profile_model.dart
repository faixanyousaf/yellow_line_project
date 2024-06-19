class Driver_Profile_Model {
  dynamic id;
  dynamic userId;
  dynamic companyId;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic dialCode;
  dynamic phone;
  dynamic accountType;
  dynamic govtId;
  dynamic drivingLicense;
  dynamic passportVisa;
  dynamic profilePhoto;
  dynamic isVerified;
  dynamic isOnline;
  dynamic vehicleAssigned;
  dynamic recoveryType;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic driverId;
  dynamic ratingAvg;
  dynamic ratingCount;

  Driver_Profile_Model(
      {this.id,
        this.userId,
        this.companyId,
        this.firstName,
        this.lastName,
        this.email,
        this.dialCode,
        this.phone,
        this.accountType,
        this.govtId,
        this.drivingLicense,
        this.passportVisa,
        this.profilePhoto,
        this.isVerified,
        this.isOnline,
        this.vehicleAssigned,
        this.recoveryType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.driverId,
        this.ratingAvg,
        this.ratingCount});

  Driver_Profile_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dialCode = json['dial_code'];
    phone = json['phone'];
    accountType = json['account_type'];
    govtId = json['govt_id'];
    drivingLicense = json['driving_license'];
    passportVisa = json['passport_visa'];
    profilePhoto = json['profile_photo'];
    isVerified = json['is_verified'];
    isOnline = json['is_online'];
    vehicleAssigned = json['vehicle_assigned'];
    recoveryType = json['recovery_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    driverId = json['driver_id'];
    ratingAvg = json['ratingAvg'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['dial_code'] = this.dialCode;
    data['phone'] = this.phone;
    data['account_type'] = this.accountType;
    data['govt_id'] = this.govtId;
    data['driving_license'] = this.drivingLicense;
    data['passport_visa'] = this.passportVisa;
    data['profile_photo'] = this.profilePhoto;
    data['is_verified'] = this.isVerified;
    data['is_online'] = this.isOnline;
    data['vehicle_assigned'] = this.vehicleAssigned;
    data['recovery_type'] = this.recoveryType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['driver_id'] = this.driverId;
    data['ratingAvg'] = this.ratingAvg;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}

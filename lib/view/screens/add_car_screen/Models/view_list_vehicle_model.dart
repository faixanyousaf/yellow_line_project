class ViewAllVehicle {
  dynamic id;
  dynamic companyId;
  dynamic userId;
  dynamic city;
  dynamic cityLogo;
  dynamic code;
  dynamic plateNumber;
  dynamic type;
  dynamic make;
  dynamic model;
  dynamic year;
  dynamic registrationCard;
  dynamic recoveryType;
  dynamic assigned;
  dynamic createdAt;
  dynamic updatedAt;

  ViewAllVehicle(
      {this.id,
      this.companyId,
      this.userId,
      this.city,
      this.cityLogo,
      this.code,
      this.plateNumber,
      this.type,
      this.make,
      this.model,
      this.year,
      this.registrationCard,
      this.recoveryType,
      this.assigned,
      this.createdAt,
      this.updatedAt});

  ViewAllVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    city = json['city'];
    cityLogo = json['city_logo'];
    code = json['code'];
    plateNumber = json['plate_number'];
    type = json['type'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    registrationCard = json['registration_card'];
    recoveryType = json['recovery_type'];
    assigned = json['assigned'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['user_id'] = this.userId;
    data['city'] = this.city;
    data['city_logo'] = this.cityLogo;
    data['code'] = this.code;
    data['plate_number'] = this.plateNumber;
    data['type'] = this.type;
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['registration_card'] = this.registrationCard;
    data['recovery_type'] = this.recoveryType;
    data['assigned'] = this.assigned;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

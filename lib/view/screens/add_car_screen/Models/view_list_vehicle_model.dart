class ViewAllVehicle {
  int? id;
  int? companyId;
  String? city;
  String? cityLogo;
  String? code;
  String? plateNumber;
  String? type;
  String? make;
  String? model;
  String? year;
  String? registrationCard;
  String? createdAt;
  String? updatedAt;

  ViewAllVehicle(
      {this.id,
        this.companyId,
        this.city,
        this.cityLogo,
        this.code,
        this.plateNumber,
        this.type,
        this.make,
        this.model,
        this.year,
        this.registrationCard,
        this.createdAt,
        this.updatedAt});

  ViewAllVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    city = json['city'];
    cityLogo = json['city_logo'];
    code = json['code'];
    plateNumber = json['plate_number'];
    type = json['type'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    registrationCard = json['registration_card'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['city'] = this.city;
    data['city_logo'] = this.cityLogo;
    data['code'] = this.code;
    data['plate_number'] = this.plateNumber;
    data['type'] = this.type;
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['registration_card'] = this.registrationCard;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

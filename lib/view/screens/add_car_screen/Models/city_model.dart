class CityModel {
  int? id;
  String? name;
  String? logoUrl;
  String? createdAt;
  String? updatedAt;

  CityModel({this.id, this.name, this.logoUrl, this.createdAt, this.updatedAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logoUrl = json['logo_url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo_url'] = this.logoUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

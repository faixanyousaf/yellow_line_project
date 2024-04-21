class RecoveryTypeModel {
  int? id;
  String? typeName;
  String? serviceCharges;
  String? status;
  String? createdAt;
  String? updatedAt;

  RecoveryTypeModel(
      {this.id,
        this.typeName,
        this.serviceCharges,
        this.status,
        this.createdAt,
        this.updatedAt});

  RecoveryTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    serviceCharges = json['service_charges'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    data['service_charges'] = this.serviceCharges;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

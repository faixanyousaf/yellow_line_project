class Request_Recovery_Model {
  String? lat1;
  String? long1;
  String? lat2;
  String? long2;
  int? plateNumber;
  int? recoveryType;

  Request_Recovery_Model(
      {this.lat1,
        this.long1,
        this.lat2,
        this.long2,
        this.plateNumber,
        this.recoveryType});

  Request_Recovery_Model.fromJson(Map<String, dynamic> json) {
    lat1 = json['lat1'];
    long1 = json['long1'];
    lat2 = json['lat2'];
    long2 = json['long2'];
    plateNumber = json['plate_number'];
    recoveryType = json['recoveryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat1'] = this.lat1;
    data['long1'] = this.long1;
    data['lat2'] = this.lat2;
    data['long2'] = this.long2;
    data['plate_number'] = this.plateNumber;
    data['recoveryType'] = this.recoveryType;
    return data;
  }
}

class Responce_fare_model {
  dynamic highestRate;
  String? recoveryTypeCharges;
  dynamic distance;
  dynamic totalCharges;

  Responce_fare_model(
      {this.highestRate,
        this.recoveryTypeCharges,
        this.distance,
        this.totalCharges});

  Responce_fare_model.fromJson(Map<String, dynamic> json) {
    highestRate = json['highestRate'];
    recoveryTypeCharges = json['recoveryTypeCharges'];
    distance = json['distance'];
    totalCharges = json['total_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highestRate'] = this.highestRate;
    data['recoveryTypeCharges'] = this.recoveryTypeCharges;
    data['distance'] = this.distance;
    data['total_charges'] = this.totalCharges;
    return data;
  }
}

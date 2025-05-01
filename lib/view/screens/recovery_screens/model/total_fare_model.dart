import 'dart:convert';

class TotalFareModel {
  Data? data;

  TotalFareModel({this.data});

  TotalFareModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new Data.fromJson(jsonDecode(json['data']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic pickupPoint;
  dynamic dropOffPoint;
  dynamic cityA;
  dynamic cityB;
  dynamic highestRate;
  dynamic lowestRate;
  dynamic recoveryTypeCharges;
  dynamic distance;
  dynamic time;
  dynamic vat;
  dynamic rate;
  dynamic totalCharges;
  dynamic pickUpLat;
  dynamic pickUpLong;
  dynamic dropLat;
  dynamic dropLong;

  Data(
      {this.pickupPoint,
      this.dropOffPoint,
      this.cityA,
      this.cityB,
      this.highestRate,
      this.lowestRate,
      this.recoveryTypeCharges,
      this.distance,
      this.time,
      this.vat,
      this.rate,
      this.totalCharges,
      this.pickUpLat,
      this.pickUpLong,
      this.dropLat,
      this.dropLong});

  Data.fromJson(Map<String, dynamic> json) {
    pickupPoint = json['pickup_point'];
    dropOffPoint = json['drop_off_point'];
    cityA = json['cityA'];
    cityB = json['cityB'];
    highestRate = json['highestRate'];
    lowestRate = json['lowestRate'];
    recoveryTypeCharges = json['recoveryTypeCharges'];
    distance = json['distance'];
    time = json['time'];
    vat = json['vat'];
    rate = json['rate'];
    totalCharges = json['total_charges'];
    pickUpLat = json['pick_up_lat'];
    pickUpLong = json['pick_up_long'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_point'] = this.pickupPoint;
    data['drop_off_point'] = this.dropOffPoint;
    data['cityA'] = this.cityA;
    data['cityB'] = this.cityB;
    data['highestRate'] = this.highestRate;
    data['lowestRate'] = this.lowestRate;
    data['recoveryTypeCharges'] = this.recoveryTypeCharges;
    data['distance'] = this.distance;
    data['time'] = this.time;
    data['vat'] = this.vat;
    data['rate'] = this.rate;
    data['total_charges'] = this.totalCharges;
    data['pick_up_lat'] = this.pickUpLat;
    data['pick_up_long'] = this.pickUpLong;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    return data;
  }
}

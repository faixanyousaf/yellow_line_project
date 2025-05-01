import 'dart:convert';

class AllAvailableDrivers {
  User? user;
  List<Data>? data;

  AllAvailableDrivers({this.user, this.data});

  AllAvailableDrivers.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  dynamic socketId;
  dynamic userId;

  User({this.socketId, this.userId});

  User.fromJson(Map<String, dynamic> json) {
    socketId = json['socketId'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socketId'] = this.socketId;
    data['user_id'] = this.userId;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic profilePicture;
  dynamic phone;
  dynamic name;
  dynamic socketId;
  dynamic lat;
  dynamic lng;
  dynamic distance;
  dynamic plateNumber;
  dynamic make;
  dynamic model;
  dynamic offeredAre;
  dynamic rating;

  Data(
      {this.id,
        this.profilePicture,
        this.phone,
        this.name,
        this.socketId,
        this.lat,
        this.lng,
        this.distance,
        this.plateNumber,
        this.make,
        this.model,
        this.offeredAre,
        this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePicture = json['profile_picture'];
    phone = json['phone'];
    name = json['name'];
    socketId = json['socketId'];
    lat = json['lat'];
    lng = json['lng'];
    distance = json['distance'];
    plateNumber = json['plate_number'];
    make = json['make'];
    model = json['model'];
    offeredAre = json['offered_are'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_picture'] = this.profilePicture;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['socketId'] = this.socketId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['distance'] = this.distance;
    data['plate_number'] = this.plateNumber;
    data['make'] = this.make;
    data['model'] = this.model;
    data['offered_are'] = this.offeredAre;
    data['rating'] = this.rating;
    return data;
  }
}

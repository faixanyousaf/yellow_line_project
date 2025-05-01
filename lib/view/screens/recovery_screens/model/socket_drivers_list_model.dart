import 'dart:convert';

class SocketDriversListModel {
  String? userSocketId;
  List<Data>? data;

  SocketDriversListModel({this.userSocketId, this.data});

  SocketDriversListModel.fromJson(Map<String, dynamic> json) {
    userSocketId = json['user_socket_id'];
    if (json['data'] != null) {
      data = <Data>[];
      jsonDecode(json['data']).forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_socket_id'] = this.userSocketId;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? socketId;
  int? userId;
  String? pickUpLat;
  String? pickUpLong;
  String? dropLat;
  String? dropLong;
  int? totalAmount;
  double? distance;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.socketId,
      this.userId,
      this.pickUpLat,
      this.pickUpLong,
      this.dropLat,
      this.dropLong,
      this.totalAmount,
      this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePicture = json['profile_picture'];
    socketId = json['socketId'];
    userId = json['user_id'];
    pickUpLat = json['pick_up_lat'];
    pickUpLong = json['pick_up_long'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    totalAmount = json['total_amount'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_picture'] = this.profilePicture;
    data['socketId'] = this.socketId;
    data['user_id'] = this.userId;
    data['pick_up_lat'] = this.pickUpLat;
    data['pick_up_long'] = this.pickUpLong;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    data['total_amount'] = this.totalAmount;
    data['distance'] = this.distance;
    return data;
  }
}

class NewBidDriverModel {
  dynamic driver;
  dynamic requestId;
  dynamic bidAmount;
  dynamic firstName;
  dynamic lastName;
  dynamic profilePicture;
  dynamic plateNumber;
  dynamic bid_id;
  dynamic pid;
  dynamic client_secret;
  bool? active;

  NewBidDriverModel(
      {this.driver,
        this.requestId,
        this.bidAmount,
        this.firstName,
        this.lastName,
        this.bid_id,
        this.profilePicture,
        this.active,
        this.plateNumber});

  NewBidDriverModel.fromJson(Map<String, dynamic> json) {
    driver = json['driver'];
    requestId = json['request_id'];
    bidAmount = json['bid_amount'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePicture = json['profile_picture'];
    plateNumber = json['plate_number'];
    bid_id = json['bid_id'];
    pid = json['pid'];
    client_secret = json['client_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver'] = this.driver;
    data['request_id'] = this.requestId;
    data['bid_amount'] = this.bidAmount;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_picture'] = this.profilePicture;
    data['plate_number'] = this.plateNumber;
    return data;
  }
}

class LoginResponceModel {
  dynamic accessToken;
  dynamic refreshToken;
  dynamic status;
  User? user;

  LoginResponceModel(
      {this.accessToken, this.refreshToken, this.status, this.user});

  LoginResponceModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic accountType;
  dynamic email;
  dynamic dialCode;
  dynamic phone;
  dynamic password;
  dynamic verificationCode;
  dynamic isVerified;
  dynamic emailVerified;
  dynamic phoneVerified;
  dynamic isSocial;
  dynamic lat;
  dynamic lng;
  dynamic profilePicture;
  dynamic isLogin;
  dynamic createdAt;
  dynamic updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.accountType,
        this.email,
        this.dialCode,
        this.phone,
        this.password,
        this.verificationCode,
        this.isVerified,
        this.emailVerified,
        this.phoneVerified,
        this.isSocial,
        this.lat,
        this.lng,
        this.profilePicture,
        this.isLogin,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    accountType = json['account_type'];
    email = json['email'];
    dialCode = json['dial_code'];
    phone = json['phone'];
    password = json['password'];
    verificationCode = json['verification_code'];
    isVerified = json['is_verified'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    isSocial = json['isSocial'];
    lat = json['lat'];
    lng = json['lng'];
    profilePicture = json['profile_picture'];
    isLogin = json['isLogin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['account_type'] = this.accountType;
    data['email'] = this.email;
    data['dial_code'] = this.dialCode;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['verification_code'] = this.verificationCode;
    data['is_verified'] = this.isVerified;
    data['email_verified'] = this.emailVerified;
    data['phone_verified'] = this.phoneVerified;
    data['isSocial'] = this.isSocial;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['profile_picture'] = this.profilePicture;
    data['isLogin'] = this.isLogin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class LoginResponceModel {
  String? accessToken;
  String? refreshToken;
  String? status;
  bool? phoneVerified;
  bool? emailVerified;
  User? user;

  LoginResponceModel(
      {this.accessToken,
      this.refreshToken,
      this.status,
      this.phoneVerified,
      this.emailVerified,
      this.user});

  LoginResponceModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    status = json['status'];
    phoneVerified = json['phone_verified'];
    emailVerified = json['email_verified'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['status'] = this.status;
    data['phone_verified'] = this.phoneVerified;
    data['email_verified'] = this.emailVerified;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? accountType;
  String? companyName;
  String? companyType;
  String? companyLogo;
  String? companyLicense;
  String? email;
  String? dialCode;
  String? phone;
  String? password;
  dynamic verificationCode;
  String? isVerified;
  String? emailVerified;
  String? phoneVerified;
  String? createdAt;
  String? updatedAt;
  String? first_name;
  String? last_name;

  User(
      {this.id,
      this.accountType,
      this.companyName,
      this.companyType,
      this.companyLogo,
      this.companyLicense,
      this.email,
      this.dialCode,
      this.phone,
      this.password,
      this.verificationCode,
      this.isVerified,
      this.emailVerified,
      this.phoneVerified,
      this.createdAt,
      this.updatedAt,
      this.first_name,
      this.last_name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    accountType = json['account_type'];
    companyName = json['company_name'];
    companyType = json['company_type'];
    companyLogo = json['company_logo'];
    companyLicense = json['company_license'];
    email = json['email'];
    dialCode = json['dial_code'];
    phone = json['phone'];
    password = json['password'];
    verificationCode = json['verification_code'];
    isVerified = json['is_verified'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['account_type'] = this.accountType;
    data['company_name'] = this.companyName;
    data['company_type'] = this.companyType;
    data['company_logo'] = this.companyLogo;
    data['company_license'] = this.companyLicense;
    data['email'] = this.email;
    data['dial_code'] = this.dialCode;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['verification_code'] = this.verificationCode;
    data['is_verified'] = this.isVerified;
    data['email_verified'] = this.emailVerified;
    data['phone_verified'] = this.phoneVerified;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

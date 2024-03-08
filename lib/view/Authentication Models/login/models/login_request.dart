class Sign_In_Request {
  String? email;
  String? password;
  String? account_type;

  Sign_In_Request({this.email, this.password, this.account_type});

  Sign_In_Request.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    account_type = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['account_type'] = this.account_type;
    return data;
  }
}

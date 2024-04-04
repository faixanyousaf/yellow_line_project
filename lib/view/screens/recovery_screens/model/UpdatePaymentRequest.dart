class UpdatePaymentRequest {
  int? paid;
  int? requestId;

  UpdatePaymentRequest({this.paid, this.requestId});

  UpdatePaymentRequest.fromJson(Map<String, dynamic> json) {
    paid = json['paid'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paid'] = this.paid;
    data['request_id'] = this.requestId;
    return data;
  }
}

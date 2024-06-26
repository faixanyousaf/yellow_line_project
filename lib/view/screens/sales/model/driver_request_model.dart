class DriverRequestModel {
  dynamic totalRevenue;
  dynamic totalRevenueToDate;
  dynamic totalRequests;
  dynamic requestsCompleted;
  dynamic requestsActive;
  dynamic totalRequestsToDate;
  dynamic requestsCompletedToDate;

  DriverRequestModel(
      {this.totalRevenue,
        this.totalRevenueToDate,
        this.totalRequests,
        this.requestsCompleted,
        this.requestsActive,
        this.totalRequestsToDate,
        this.requestsCompletedToDate});

  DriverRequestModel.fromJson(Map<String, dynamic> json) {
    totalRevenue = json['total_revenue'];
    totalRevenueToDate = json['total_revenue_to_date'];
    totalRequests = json['total_requests'];
    requestsCompleted = json['requests_completed'];
    requestsActive = json['requests_active'];
    totalRequestsToDate = json['total_requests_to_date'];
    requestsCompletedToDate = json['requests_completed_to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_revenue'] = this.totalRevenue;
    data['total_revenue_to_date'] = this.totalRevenueToDate;
    data['total_requests'] = this.totalRequests;
    data['requests_completed'] = this.requestsCompleted;
    data['requests_active'] = this.requestsActive;
    data['total_requests_to_date'] = this.totalRequestsToDate;
    data['requests_completed_to_date'] = this.requestsCompletedToDate;
    return data;
  }
}

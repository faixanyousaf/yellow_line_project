class FirebaseModel {
  bool? iosMatchVersion;
  String? iosAppUrl;
  String? baseUrl;
  String? androidVersion;
  String? iosVersion;
  bool? androidAppOnMaintenance;
  String? androidAppUrl;
  bool? androidMatchVersion;
  bool? iosAppOnMaintenance;
  bool? registration;
  bool? screenshot;

  FirebaseModel(
      {this.iosMatchVersion,
        this.iosAppUrl,
        this.baseUrl,
        this.androidVersion,
        this.iosVersion,
        this.androidAppOnMaintenance,
        this.androidAppUrl,
        this.androidMatchVersion,
        this.registration,
        this.screenshot,
        this.iosAppOnMaintenance});

  FirebaseModel.fromJson(Map<String, dynamic> json) {
    iosMatchVersion = json['ios-match-version'];
    iosAppUrl = json['ios-app-url'];
    baseUrl = json['base-url'];
    androidVersion = json['android-version'];
    iosVersion = json['ios-version'];
    androidAppOnMaintenance = json['android-app-on-maintenance'];
    androidAppUrl = json['android-app-url'];
    androidMatchVersion = json['android-match-version'];
    iosAppOnMaintenance = json['ios-app-on-maintenance'];
    registration = json['registration'];
    screenshot = json['screenshot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ios-match-version'] = this.iosMatchVersion;
    data['ios-app-url'] = this.iosAppUrl;
    data['base-url'] = this.baseUrl;
    data['android-version'] = this.androidVersion;
    data['ios-version'] = this.iosVersion;
    data['android-app-on-maintenance'] = this.androidAppOnMaintenance;
    data['android-app-url'] = this.androidAppUrl;
    data['android-match-version'] = this.androidMatchVersion;
    data['ios-app-on-maintenance'] = this.iosAppOnMaintenance;
    data['registration'] = this.registration;
    data['screenshot'] = this.screenshot;
    return data;
  }
}

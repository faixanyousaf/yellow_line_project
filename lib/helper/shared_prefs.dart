import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final storage = GetStorage();
  // final String _countriesResponseKey = 'Countries';
  // final String _staticResourceKey = 'resource';
  // final String _profilePathKey = 'Profile pic path';
  final String _saveUserDataKey = 'Save user';
  final String _tokenKey = 'Save token';
  final String _user_id_Key = 'user id';
  final String _as_login_Key = 'login as a business or driver';
  // final String _itineraryIDKey = 'Save Key';
  // final String _destinationCountryKey = 'Destination Country Key';
  // final String _checkListKey = 'CheckListKey';
  // final String _locationKey = 'Location Enabled';
  // final String visit_view_key = 'visit_view_key';
  // final String _locationPrivacyKey = 'Location privacy status';
  // final String _locationPurchasePrivacyKey = 'Location purchase privacy status';
  // final String _savePasswordKey = 'Save password';
  // final String _NotificationCheckKey = 'Notification check';

//   Future getTempCheckList() async {
//     final prefs = await SharedPreferences.getInstance();
//     return json.decode(prefs.getString(_checkListKey)!);
//   }
//
//   Future<void> saveTempCheckList(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_checkListKey, json.encode(value));
//   }
//
//   Future getDestinationCountries() async {
//     final prefs = await SharedPreferences.getInstance();
//     return json.decode(prefs.getString(_destinationCountryKey)!);
//   }
//
//   Future<void> saveDestinationCountries(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_destinationCountryKey, json.encode(value));
//   }
//
  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String val = prefs.getString(_saveUserDataKey) ?? '';
    if (val.isEmpty) {
      return val;
    }
    return json.decode(val);
  }

  Future<void> saveUser(dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_saveUserDataKey, json.encode(value));
  }

//
//   Future<dynamic> getCountries() async {
//     final prefs = await SharedPreferences.getInstance();
//     var data = prefs.getString(_countriesResponseKey);
//     if (data == null) {
//       return '';
//     }
//     return json.decode(data);
//   }
//
//   Future<void> saveCountries(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_countriesResponseKey, json.encode(value));
//   }
//
//   Future<dynamic> getResource() async {
//     final prefs = await SharedPreferences.getInstance();
//     var data = prefs.getString(_staticResourceKey);
//     if (data == null) {
//       return '';
//     }
//     return json.decode(data);
//   }
//
//   Future<void> saveResource(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_staticResourceKey, json.encode(value));
//   }
//
//   Future getProfilePath() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_profilePathKey);
//   }
//
//   Future<void> saveProfilePath(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_profilePathKey, value ?? '');
//   }
//
  Future getaslogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_as_login_Key);
  }

  Future<void> saveaslogin(dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_as_login_Key, value);
  }

  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveToken(dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, value);
  }

  Future getid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_user_id_Key);
  }

  Future<void> saveid(dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_user_id_Key, value.toString());
  }

//
//   Future getItineraryID() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_itineraryIDKey);
//   }
//
//   Future<void> saveItineraryID(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_itineraryIDKey, value);
//   }
//
//   Future getLocationStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_locationKey);
//   }
//
//   Future<void> saveLocationLocationStatus(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_locationKey, value);
//   }
//
//   Future locationPrivacyStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_locationPrivacyKey);
//   }
//
//   Future<void> saveLocationPrivacyStatus(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_locationPrivacyKey, value);
//   }
//
//   Future locationPurchasePrivacyStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_locationPurchasePrivacyKey);
//   }
//
//   Future<void> savePurchaseLocationPrivacyStatus(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_locationPurchasePrivacyKey, value);
//   }
//
//   Future getPassword() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_savePasswordKey);
//   }
//
//   Future<void> savePass(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_savePasswordKey, value);
//   }
//   Future getNotificationCheck() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_NotificationCheckKey);
//   }
//
//   Future<void> saveNotificationCheck(dynamic value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_NotificationCheckKey, value);
//   }
//
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
// }
//
// class VisitView {
//   bool? home;
//   bool? mapView;
//   bool? profile;
//   bool? soldIteniry;
//   bool? draftIteniry;
//
//   VisitView(
//       {this.home = true,
//       this.mapView = false,
//       this.profile = false,
//       this.soldIteniry = false,
//       this.draftIteniry = false});
//
//   VisitView.fromJson(Map<String, dynamic> json) {
//     home = json['home'];
//     mapView = json['map_view'];
//     profile = json['profile'];
//     soldIteniry = json['sold_iteniry'];
//     draftIteniry = json['draft_iteniry'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['home'] = this.home;
//     data['map_view'] = this.mapView;
//     data['profile'] = this.profile;
//     data['sold_iteniry'] = this.soldIteniry;
//     data['draft_iteniry'] = this.draftIteniry;
//     return data;
//   }
}

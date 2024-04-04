import 'dart:developer';
import '../../core/core.dart';

class YellowLineAPI {
  YellowLineAPI();
  final _http = HTTP.instance;

  /// Authentication
  Future<dynamic> signIn({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.login;
      log('url......$url', name: 'signIn | YellowLineAPI');
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get_all_cities({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.cities + '$body';
      log('url......$url', name: 'signIn | YellowLineAPI');
      return await _http.iGet(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signup({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.signup;
      return await _http.iPost_form_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> social_signup({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.socail_signup;
      return await _http.iPost(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> calculate_fare({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.get_fare;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get_view_request({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.myrequests_by_status;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> charge_user({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.charge_user;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> update_payment_status({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.update_payment_status;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> update_location({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.update_location;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> update_charge_user({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.update_charge_user;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get_vehicle({required id}) async {
    try {
      String url = '';
      url = ApiRoutes.get_vehicle + id;
      return await _http.iGet(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get_all_drivers({required id}) async {
    try {
      String url = '';
      url = ApiRoutes.get_all_drivers + id;
      log('url......$url', name: 'get_all_drivers | YellowLineAPI');
      return await _http.iGet(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete_driver({String? id}) async {
    try {
      String url = '';
      url = ApiRoutes.delete_drivers + "$id";
      var data = await _http.iDelete(
        url,
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

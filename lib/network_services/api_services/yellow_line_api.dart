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

  Future<dynamic> my_pending_requests({required id}) async {
    try {
      String url = '';
      url = ApiRoutes.my_pending_requests + id;
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

  Future<dynamic> cancel_ride({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.cancel_ride;
      return await _http.iPost_form_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> update_user_profile({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.update_user_profile;
      return await _http.iPut(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> update_user_profile_picture({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.update_user_profile_picture;
      return await _http.iPut_form_data(url, data: body);
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

  Future<dynamic> business_all_requests_by_years({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.business_all_requests_by_years;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> business_all_requests_by_month({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.business_all_requests_by_month;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> business_all_requests_by_week({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.business_all_requests_by_week;
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> business_all_requests({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.company_all_requests;
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

  Future<dynamic> check_duplicate({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.checkduplicate;
      log('url......$url', name: 'get_all_drivers | YellowLineAPI');
      return await _http.iPost_raw_data(url, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get_recovery_type() async {
    try {
      String url = '';
      url = 'https://yellowline.codeels.pro/admin/recoverytypes';
      log('url......$url', name: 'add_drivers | YellowLineAPI');
      return await _http.iGet(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get_cites() async {
    try {
      String url = '';
      url = ApiRoutes.get_cites;
      log('url......$url', name: 'add_drivers | YellowLineAPI');
      return await _http.iGet(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> get_driver_profile({required id}) async {
    try {
      String url = '';
      url = ApiRoutes.driver_profile + id;
      log('url......$url', name: 'add_drivers | YellowLineAPI');
      return await _http.iGet(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> rate_driver({required body}) async {
    try {
      String url = '';
      url = ApiRoutes.rate_driver;
      log('url......$url', name: 'rate_driver | YellowLineAPI');
      return await _http.iPost_raw_data(url, data: body);
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

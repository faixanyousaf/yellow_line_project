import 'dart:developer';
import '../../../view/Authentication Models/login/models/login_Responce_model.dart';
import '../../api_services/yellow_line_api.dart';

class UserRepository {
  UserRepository._privateConstructor();

  static final UserRepository _instance = UserRepository._privateConstructor();

  static UserRepository get instance => _instance;

  final YellowLineAPI _saryaAPI = YellowLineAPI();

  Future<dynamic> calculate_fare({required body}) async {
    try {
      log('body......$body', name: 'calculate_fare | AuthRepository');
      var data = await _saryaAPI.calculate_fare(body: body);
      log('data......$data', name: 'calculate_fare | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'calculate_fare | AuthRepository');
      rethrow;
    }
  }

  Future<dynamic> get_view_request({required body}) async {
    try {
      log('body......$body', name: 'get_view_request | AuthRepository');
      var data = await _saryaAPI.get_view_request(body: body);
      log('data......$data', name: 'get_view_request | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'get_view_request | AuthRepository');
      rethrow;
    }
  }

  Future<dynamic> charge_user({required body}) async {
    try {
      log('body......$body', name: 'calculate_fare | AuthRepository');
      var data = await _saryaAPI.charge_user(body: body);
      log('data......$data', name: 'calculate_fare | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'calculate_fare | AuthRepository');
      rethrow;
    }
  }

  Future<dynamic> update_payment_status({required body}) async {
    try {
      log('body......$body', name: 'update_payment_status | AuthRepository');
      var data = await _saryaAPI.update_payment_status(body: body);
      log('data......$data', name: 'update_payment_status | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'update_payment_status | AuthRepository');
      rethrow;
    }
  }

  Future<dynamic> update_location({required body}) async {
    try {
      log('body......$body', name: 'update_location | AuthRepository');
      var data = await _saryaAPI.update_location(body: body);
      log('data......$data', name: 'update_location | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'update_location | AuthRepository');
      rethrow;
    }
  }

  Future<dynamic> update_charge_user({required body}) async {
    try {
      log('body......$body', name: 'update_charge_user | AuthRepository');
      var data = await _saryaAPI.update_charge_user(body: body);
      log('data......$data', name: 'update_charge_user | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'update_charge_user | AuthRepository');
      rethrow;
    }
  }

  Future<dynamic> get_vehicle({required id}) async {
    try {
      log('body......$id', name: 'get_vehicle | AuthRepository');
      var data = await _saryaAPI.get_vehicle(id: id);
      log('data......$data', name: 'get_vehicle | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'get_vehicle | AuthRepository');
      rethrow;
    }
  }

  Future check_duplicate({required body}) async {
    try {
      log('body......$body', name: 'get_all_drivers | BusinessRepository');

      var data = await _saryaAPI.check_duplicate(body: body);

      log('data......$data', name: 'get_all_drivers | BusinessRepository');

      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'get_all_drivers | BusinessRepository');
      rethrow;
    }
  }

  Future get_recovery_type() async {
    try {
      log('body......', name: 'add_vehicle | BusinessRepository');

      var data = await _saryaAPI.get_recovery_type();

      log('data......$data', name: 'add_vehicle | BusinessRepository');

      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'add_drivers | BusinessRepository');
      rethrow;
    }
  }

  Future get_cites() async {
    try {
      log('body......', name: 'add_vehicle | BusinessRepository');

      var data = await _saryaAPI.get_cites();

      log('data......$data', name: 'add_vehicle | BusinessRepository');

      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'add_drivers | BusinessRepository');
      rethrow;
    }
  }

  Future get_driver_profile({required id}) async {
    try {
      log('body......', name: 'get_driver_profile | BusinessRepository');

      var data = await _saryaAPI.get_driver_profile(id: id);

      log('data......$data', name: 'get_driver_profile | BusinessRepository');

      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'get_driver_profile | BusinessRepository');
      rethrow;
    }
  }

  Future rate_driver({required body}) async {
    try {
      log('body......', name: 'rate_driver | BusinessRepository');

      var data = await _saryaAPI.rate_driver(body: body);

      log('data......$data', name: 'rate_driver | BusinessRepository');

      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'add_drivers | BusinessRepository');
      rethrow;
    }
  }
}

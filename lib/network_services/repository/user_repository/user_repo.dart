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
}

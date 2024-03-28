import 'dart:developer';
import '../../../view/Authentication Models/login/models/login_Responce_model.dart';
import '../../api_services/yellow_line_api.dart';

class AuthRepository {
  AuthRepository._privateConstructor();

  static final AuthRepository _instance = AuthRepository._privateConstructor();

  static AuthRepository get instance => _instance;

  final YellowLineAPI _saryaAPI = YellowLineAPI();

  Future<LoginResponceModel> signIn({required body}) async {
    try {
      log('body......$body', name: 'signIn | AuthRepository');

      var data = await _saryaAPI.signIn(body: body);

      log('data......$data', name: 'signIn | AuthRepository');

      return LoginResponceModel.fromJson(data);
    } catch (e) {
      log('catch error......${e.toString()}', name: 'signIn | AuthRepository');
      rethrow;
    }
  }

  Future signUp({required body}) async {
    try {
      log('body......$body', name: 'signIn | AuthRepository');

      var data = await _saryaAPI.signup(body: body);

      log('data......$data', name: 'signIn | AuthRepository');

      return data;
    } catch (e) {
      log('catch......${e.toString()}', name: 'signUn | AuthRepository');

      rethrow;
    }
  }

  Future social_signUp({required body}) async {
    try {
      log('body......$body', name: 'signIn | AuthRepository');

      var data = await _saryaAPI.social_signup(body: body);

      log('data......$data', name: 'signIn | AuthRepository');

      return data;
    } catch (e) {
      log('catch......${e.toString()}', name: 'signUn | AuthRepository');

      rethrow;
    }
  }
}

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

  Future<dynamic> my_pending_requests({required id}) async {
    try {
      log('body......$id', name: 'get_view_request | AuthRepository');
      var data = await _saryaAPI.my_pending_requests(id: id);
      log('data......$data', name: 'get_view_request | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'get_view_request | AuthRepository');
      rethrow;
    }
  }

  Future<dynamic> check_review({required id}) async {
    try {
      log('body......$id', name: 'get_view_request | AuthRepository');
      var data = await _saryaAPI.check_review(id: id);
      log('data......$data', name: 'get_view_request | AuthRepository');
      return data;
    } catch (e) {
      log('catch error......${e.toString()}',
          name: 'get_view_request | AuthRepository');
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

  Future submit_review({required body}) async {
    try {
      log('body......$body', name: 'signIn | AuthRepository');

      var data = await _saryaAPI.submit_review(body: body);

      log('data......$data', name: 'signIn | AuthRepository');

      return data;
    } catch (e) {
      log('catch......${e.toString()}', name: 'signUn | AuthRepository');

      rethrow;
    }
  }

  Future cancel_ride({required body}) async {
    try {
      log('body......$body', name: 'signIn | AuthRepository');

      var data = await _saryaAPI.cancel_ride(body: body);

      log('data......$data', name: 'signIn | AuthRepository');

      return data;
    } catch (e) {
      log('catch......${e.toString()}', name: 'signUn | AuthRepository');

      rethrow;
    }
  }

  Future update_user_profile({required body}) async {
    try {
      log('body......$body', name: 'signIn | AuthRepository');

      var data = await _saryaAPI.update_user_profile(body: body);

      log('data......$data', name: 'signIn | AuthRepository');

      return data;
    } catch (e) {
      log('catch......${e.toString()}', name: 'signUn | AuthRepository');

      rethrow;
    }
  }

  Future update_user_profile_picture({required body}) async {
    try {
      log('body......$body', name: 'signIn | AuthRepository');

      var data = await _saryaAPI.update_user_profile_picture(body: body);

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

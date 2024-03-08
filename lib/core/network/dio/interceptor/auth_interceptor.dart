import 'dart:developer';
import 'package:dio/dio.dart';
// import '../../../../gen_2/authentication/signin/models/error_response_model.dart';
// import '../../../../gen_2/authentication/signin/view/login_screen.dart';
// import '../../../../helper/show_snake_bar.dart';

class AuthInterceptors extends Interceptor {
  final Dio dio;

  AuthInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('response.statusCode......${response.statusCode}',
        name: 'onResponse | AuthRepository');

    if (response.statusCode == 403 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      log('response.statusCode......${response.statusCode}',
          name: 'onResponse | AuthRepository');
    } else if (response.statusCode == 206) {}
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log('response.statusCode......${err.response?.statusCode}',
        name: 'onError | AuthRepository');

    if (err.response?.statusCode == 400 ||
        err.response?.statusCode == 403 ||
        err.response?.statusCode == 401 ||
        err.response?.statusCode == 409 ||
        err.response?.statusCode == 404) {
      log('response.statusCode......${err.response?.statusCode}',
          name: 'onError | AuthRepository');
      log('response.statusCode......${err.response?.data.toString()}',
          name: 'onError | AuthRepository');
      //ErrorModel errorModel = ErrorModel.fromJson(err.response?.data);

      // if (errorModel.msg.toString().toLowerCase() == 'user not found!' ||
      //     errorModel.msg.toString().toLowerCase() == 'incorrect password' ||
      //     errorModel.msg.toString() == 'User is suspended!') {
      //   login_error_msg.value = errorModel.msg ?? '';
      //   //ShowSnackBar.showSnackBar(msg: errorModel.msg ?? '');
      // }
    } else {}
    handler.next(err);
  }
}

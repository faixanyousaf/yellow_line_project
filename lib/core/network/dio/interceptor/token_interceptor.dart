import 'package:dio/dio.dart';
import '../../../../helper/shared_prefs.dart';

class TokenInterceptors extends Interceptor {
  // ignore: prefer_typing_uninitialized_variables
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPrefs prefs = SharedPrefs();
    var token = await prefs.getToken();
    print("tokent is ..........$token");
    options.headers['Authorization'] = token;

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }
}

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../connectivity/dio_connectivity_request_retrier.dart';

class AppInterceptors extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  AppInterceptors({
    required this.requestRetrier,
  });

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        // Let any new error from the retrier pass through
        return e;
      }
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      throw TimeoutException("");
    }
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout &&
        err.error != null &&
        err.error is SocketException;
  }
}

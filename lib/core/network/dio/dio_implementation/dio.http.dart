import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '/core/core.dart';

class HTTP implements IHTTP {
  final Dio _dio = Dio();
  HTTP._privateConstructor() {
    _dio.interceptors.add(AuthInterceptors(_dio));
    _dio.interceptors.add(TokenInterceptors());
  }

  static final HTTP _instance = HTTP._privateConstructor();

  static HTTP get instance => _instance;

  @override
  Future<dynamic> iDelete(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var res =
          await _dio.delete(url, data: data, queryParameters: queryParameters);
      var result = ApiResponse().response(res);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> iGet(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      log('1.....', name: 'iGet | arayaaApi');

      var res = await _dio.get(url, queryParameters: queryParameters);
      log('2.....', name: 'iGet | arayaaApi');

      var result = ApiResponse().response(res);
      return result;
    } catch (e) {
      log('1.....${e.toString()}', name: 'catch | iget');

      rethrow;
    }
  }

  @override
  Future<dynamic> iPost(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var res =
          await _dio.post(url, data: data, queryParameters: queryParameters);
      var result = ApiResponse().response(res);
      return result;
    } catch (e) {
      log('catch......${e.toString()}', name: 'iPost | AuthRepository');
      rethrow;
    }
  }

  @override
  Future<dynamic> iPost_raw_data(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var res = await _dio.post(url,
          options: Options(
            headers: {'Content-Type': "application/x-www-form-urlencoded"},
          ),
          data: data);
      var result = ApiResponse().response(res);
      return result;
    } catch (e) {
      log('catch......${e.toString()}', name: 'iPost | AuthRepository');
      rethrow;
    }
  }

  @override
  Future<dynamic> iPost_form_data(String url,
      {dynamic data,
        Map<String, dynamic>? queryParameters}) async {
    try {
      var res = await _dio.post(url,
          options: Options(
            headers: {'Content-Type': "application/x-www-form-urlencoded"},
          ),
          data: data);
      var result = ApiResponse().response(res);
      return result;
    } catch (e) {
      log('catch......${e.toString()}', name: 'iPost | AuthRepository');
      rethrow;
    }
  }

  @override
  Future<dynamic> iPut(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var res = await _dio.put(url,
          data: json.encode(data), queryParameters: queryParameters);
      var result = ApiResponse().response(res);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future iPTCH(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    var res =
        await _dio.patch(url, data: data, queryParameters: queryParameters);
    var result = ApiResponse().response(res);
    return result;
  }
}

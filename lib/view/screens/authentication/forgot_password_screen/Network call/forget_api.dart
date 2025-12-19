import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import '../../../../../core/network/routes/base_url.dart';
import '../../../../../helper/shared_prefs.dart';

const forgetCodeUrl = 'auth/code/users';
const resetPasswordUrl = 'auth/reset/users';

Future forget_mail_send_api({required Map<String, dynamic> map}) async {
  SharedPrefs sf = SharedPrefs();
  var tocken = await sf.getToken();
  final response =
      await dio.Dio().post('${base_URL}auth/code/users',
          options: dio.Options(
            headers: {'Content-Type': "application/x-www-form-urlencoded"},
          ),
          data: map);
  var data = response.data;
  print(' the response is =${data}');
  return data;
}

Future reset_password_api({required Map<String, dynamic> map}) async {
  SharedPrefs sf = SharedPrefs();
  var tocken = await sf.getToken();
  final response =
      await dio.Dio().post('${base_URL}auth/reset/users',
          options: dio.Options(
            headers: {'Content-Type': "application/x-www-form-urlencoded"},
          ),
          data: map);
  var data = response.data;
  print(' the response is =${data}');
  return data;
}

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import '../../../../../helper/shared_prefs.dart';

dynamic baseUrl = 'http://yellowline.codeels.pro/';
const forgetCodeUrl = 'auth/code/users';
const resetPasswordUrl = 'auth/reset/users';

Future forget_mail_send_api({required Map<String, dynamic> map}) async {
  SharedPrefs sf = SharedPrefs();
  var tocken = await sf.getToken();
  final response = await http.get(Uri.parse('http://yellowline.codeels.pro/auth/code/users'));
  var data = response.body;
  print( ' the response is =${data}');
  return data;
}

Future reset_password_api({required Map<String, dynamic> map}) async {
  SharedPrefs sf = SharedPrefs();
  var tocken = await sf.getToken();
  final response = await http.get(Uri.parse('http://yellowline.codeels.pro/auth/reset/users'));
  var data = response.body;
  print( ' the response is =${data}');
  return data;
}
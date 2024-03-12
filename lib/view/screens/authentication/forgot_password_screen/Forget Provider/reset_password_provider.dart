import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../../helper/navigation/navigation_object.dart';
import '../../../../../helper/navigation/router_path.dart';
import '../Network call/forget_api.dart';

class ResetPasswordProvider extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isPasswordShow = false;
  bool isPasswordShow1 = false;
  bool loading = false;
  updateState() {
    notifyListeners();
  }
  final formKey = GlobalKey<FormState>();
  reset_password_api_function({String? email,String? otp}) async {
    if(formKey.currentState!.validate()){
      loading = true;
      updateState();
      var result = await reset_password_api(
          map: {
            'password': passwordController.text,
            'token': otp,
            'email': email,
          }
      );
      loading = false;
      updateState();
      print('result.....$result');
       navigationService.navigatePushReplace(RouterPath.loginRout);
     // navigationService.navigateTo(RouterPath.Otp_Screen);
    }


  }
}

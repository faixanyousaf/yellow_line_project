import 'package:flutter/material.dart';
import '../../../../../helper/navigation/navigation_object.dart';
import '../../../../../helper/navigation/router_path.dart';
import '../../../../../helper/shared_prefs.dart';
import '../../../../../network_services/repository/authentication_repository/auth_repo.dart';
import '../models/login_Responce_model.dart';
import '../models/login_request.dart';

class LoginProvider extends ChangeNotifier {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  bool isPasswordShow = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? validate_email_phone(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    return emailValid;
  }

  String? validate_password(String? value) {
    if (value!.length < 10) {
      return 'Password must be more than 8 character';
    } else {
      return null;
    }
  }

  login_api(BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      try {
        loading = true;
        updateState();
        Sign_In_Request request = Sign_In_Request(
            password: passwordController.text,
            email: emailController.text,
            account_type: '2');
        var result =
            await AuthRepository.instance.signIn(body: request.toJson());
        LoginResponceModel responceModel = result as LoginResponceModel;
        print('${responceModel.toJson()}');
        SharedPrefs sf = SharedPrefs();
        sf.saveUser(responceModel.toJson());
        sf.saveToken(responceModel.accessToken);
        sf.saveaslogin('1');
        sf.saveid(responceModel.user!.id.toString());
        sf.save_password(passwordController.text);
        loading = false;
        updateState();
        navigationService.navigatePushReplace(RouterPath.Home_Screen);
      } catch (e) {
        loading = false;
        updateState();
      }
    }
  }

  social_login({BuildContext? context, Map<String, dynamic>? map}) async {
    try {
      loading = true;
      updateState();
      var result = await AuthRepository.instance.social_signUp(body: map);
      print('result....$result');
      LoginResponceModel responceModel = LoginResponceModel.fromJson(result);
      print('${responceModel.toJson()}');
      SharedPrefs sf = SharedPrefs();
      sf.saveUser(responceModel.toJson());
      sf.saveToken(responceModel.accessToken);
      sf.saveaslogin('2');
      sf.saveid(responceModel.user!.id.toString());
      loading = false;
      updateState();
      navigationService.navigatePushReplace(RouterPath.Home_Screen);
    } catch (e) {
      print('Exception.....$e');
      loading = false;
      updateState();
    }
  }

  updateState() {
    notifyListeners();
  }
}

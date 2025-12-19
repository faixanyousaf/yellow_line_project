import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../../../../helper/navigation/navigation_object.dart';
import '../../../../../helper/navigation/router_path.dart';
import '../../../../../network_services/repository/authentication_repository/auth_repo.dart';
import '../../../../helper/shared_prefs.dart';
import '../../login/models/login_Responce_model.dart';

class SingUpProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String country_code = '+971';
  String company_type = 'Osaka';
  File? liceince;
  File? logo;
  bool loading = false;
  bool isVisible = false;
  bool isPending = false;
  bool isPasswordShow = false;
  ImagePicker picker = ImagePicker();
  FocusNode focusNode = FocusNode();
  int? index = 2;

  company_liceince() async {
    final XFile? result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      liceince = File(result.path);
      updateState();
    }
  }

  company_logo() async {
    final XFile? result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      logo = File(result.path);
      updateState();
    }
  }

  updateState() {
    notifyListeners();
  }

  String? companyTypeName;
  List<String>? companyType = [
    'Hyundai',
    'Toyota',
    'MG',
    'Honda Atlas',
    'Changan',
    'PAK Suzuki',
  ];
  bool? validate_email_phone(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    return emailValid;
  }

  call_sign_up(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      updateState();
      try {
        FormData data = FormData.fromMap({
          'email': emailController.text,
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'phone': phoneController.text,
          'dial_code': country_code,
          'password': passwordController.text,
        });
        var result = await AuthRepository.instance.signUp(body: data);
        loading = false;
        updateState();
        LoginResponceModel responceModel = LoginResponceModel.fromJson(result);
        print('${responceModel.toJson()}');
        SharedPrefs sf = SharedPrefs();
        sf.saveUser(responceModel.toJson());
        sf.saveToken(responceModel.accessToken);
        sf.saveaslogin('1');
        sf.saveid(responceModel.user!.id.toString());
        sf.save_password(passwordController.text);
        loading = false;
        updateState();
        navigationService.navigateTo(
                                  RouterPath.add_request_screen_one);
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
      LoginResponceModel responceModel = LoginResponceModel.fromJson(result);
      print('${responceModel.toJson()}');
      SharedPrefs sf = SharedPrefs();
      sf.saveUser(responceModel.toJson());
      sf.saveToken(responceModel.accessToken);
      sf.saveaslogin('1');
      sf.saveid(responceModel.user!.id.toString());
      loading = false;
      updateState();
      navigationService.navigateTo(
                                  RouterPath.add_request_screen_one);
    } catch (e) {
      loading = false;
      updateState();
    }
  }
}

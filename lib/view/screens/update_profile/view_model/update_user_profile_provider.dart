import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../../../../helper/navigation/navigation_object.dart';
import '../../../../../helper/shared_prefs.dart';
import '../../../../../network_services/repository/authentication_repository/auth_repo.dart';
import '../../../Authentication Models/login/models/login_Responce_model.dart';
import '../../../Authentication Models/login/models/login_request.dart';
import '../../home_page/home_screen.dart';

class UpdateUserProfileProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController first_name_Controller = TextEditingController();
  TextEditingController last_name_Controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String country_code = '+971';
  File? liceince;
  File? logo;
  bool loading = false;
  bool isVisible = false;
  ImagePicker picker = ImagePicker();

  FocusNode focusNode = FocusNode();

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
    SharedPrefs sf = SharedPrefs();
    FormData data = FormData.fromMap({
      'profile_picture': await MultipartFile.fromFile(logo!.path),
      'user_id': await sf.getid()
    });
    await AuthRepository.instance.update_user_profile_picture(body: data);
    var password = await sf.get_password();
    Sign_In_Request request = Sign_In_Request(
        password: password, email: emailController.text, account_type: '2');
    var responce = await AuthRepository.instance.signIn(body: request.toJson());
    LoginResponceModel responceModel = responce;
    print('${responceModel.toJson()}');
    sf.saveUser(responceModel.toJson());
    sf.saveToken(responceModel.accessToken);
    sf.saveaslogin('1');
    sf.saveid(responceModel.user!.id.toString());
  }

  updateState() {
    notifyListeners();
  }

  bool? validate_email_phone(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    return emailValid;
  }

  call_update_profile(BuildContext context) async {
    try {
      loading = true;
      updateState();
      print('step 1');
      var data = {
        'first_name': first_name_Controller.text,
        'last_name': last_name_Controller.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'dial_code': country_code,
      };
      print('step 2');
      var update_profile_result =
          await AuthRepository.instance.update_user_profile(body: data);
      print('step 3');
      print('result.....$update_profile_result');
      SharedPrefs sf = SharedPrefs();
      var password = await sf.get_password();
      Sign_In_Request request = Sign_In_Request(
          password: password, email: emailController.text, account_type: '2');
      var result = await AuthRepository.instance.signIn(body: request.toJson());
      LoginResponceModel responceModel = result;
      print('${responceModel.toJson()}');
      sf.saveUser(responceModel.toJson());
      sf.saveToken(responceModel.accessToken);
      sf.saveaslogin('1');
      sf.saveid(responceModel.user!.id.toString());
      navigationService.pushAndRemoveUntil(HomeScreen());
      loading = false;
      updateState();
    } catch (e) {
      print('exception $e');
      loading = false;
      updateState();
    }
  }
}

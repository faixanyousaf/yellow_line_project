import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../../../../helper/navigation/navigation_object.dart';
import '../../../../../helper/navigation/router_path.dart';
import '../../../../../network_services/repository/authentication_repository/auth_repo.dart';

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
    bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    return emailValid;
  }
  final formKey = GlobalKey<FormState>();
  call_sign_up() async {
     if(formKey.currentState!.validate()){
       loading = true;
       updateState();
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
       print('result.....$result');
       // navigationService.navigatePushReplace(RouterPath.loginRout);
       navigationService.navigateTo(RouterPath.Otp_Screen);
     }


  }
}

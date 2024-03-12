import 'package:flutter/material.dart';
import '../Network call/forget_api.dart';

class ForgetProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool loading = false;


  updateState() {
    notifyListeners();
  }
  bool? validate_email_phone(String? value) {
    bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    return emailValid;
  }
  final formKey = GlobalKey<FormState>();
  call_forget_api() async {
      loading = true;
      updateState();
      var result = await forget_mail_send_api(
          map: {
            'email': emailController.text,
          }
      );
      loading = false;
      updateState();
      print('result.....$result');
      // navigationService.navigatePushReplace(RouterPath.loginRout);
      //navigationService.navigateTo(RouterPath.Otp_Screen);

  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/global_widgets/data_loading.dart';

import 'Forget Provider/forget_provider.dart';
import 'ottp_screen/ottp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int index = 1;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final ForgetProvider provider = Provider.of<ForgetProvider>(context);
    return DataLoading(
      isLoading: provider.loading,
      use_opacity: false,
      child: Scaffold(
        backgroundColor: Color(0xff181F30),
        //Colors.black,
        body: SingleChildScrollView(
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 2.h,
                          )),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        'Forgot Password!'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                //SizedBox(height: 1.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: Text(
                    'Enter your Phone Number to get OTP Verification Code'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: CustommTextField(
                    controller: provider.emailController,
                    prefixIcon: 'assets/email.svg',
                    hintText: 'Email'.tr,
                    validator: (value) {
                      bool? v = provider.validate_email_phone(value);
                      if (v == false) {
                        return 'Please enter email'.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                //   child: Row(
                //     children: [
                //       Container(
                //         height: 6.2.h,
                //         width: 26.w,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(17)
                //         ),
                //         child: IntlPhoneField(
                //           controller: phoneController,
                //           focusNode: focusNode,
                //           disableAutoFillHints: false,
                //           disableLengthCheck: true,
                //           showDropdownIcon: false,
                //           //enabled: false,
                //           flagsButtonMargin: EdgeInsets.only(left: 3.w,top: 0.3.h),
                //
                //           decoration: InputDecoration(
                //             // hintText: 'Phone Number',
                //             // hintStyle: TextStyle(fontSize: 10.sp,color: Color(0xff181F30)),
                //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
                //             fillColor: Colors.white,
                //             filled: true,
                //             disabledBorder: InputBorder.none,
                //             //contentPadding: EdgeInsets.only(bottom: 2.h),
                //           ),
                //
                //           languageCode: "en",
                //           onChanged: (phone) {
                //             print(phone.completeNumber);
                //           },
                //           onCountryChanged: (country) {
                //             print('Country changed to: ' + country.name);
                //           },
                //         ),
                //       ),
                //       SizedBox(width: 2.w,),
                //       Expanded(
                //           child: Padding(
                //             padding:  EdgeInsets.only(top: 0.5.h),
                //             child: CustommTextField(
                //               hintText: 'Mobile Number',
                //               controller: phoneController,
                //             ),
                //           ))
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 3.h,
                ),
                GestureDetector(
                  onTap: () async {
                    if (provider.formKey.currentState!.validate()) {
                      await provider.call_forget_api();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OttpScreen(
                                email: provider.emailController.text),
                          ));
                    }
                  },
                  child: CustomButton(
                    text: 'Next'.tr,
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    buttonColor: Color(0xffFFD542),
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

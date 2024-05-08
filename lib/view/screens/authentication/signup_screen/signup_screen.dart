import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yellowline/global_widgets/custom_google_button.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';
import '../../../../global_widgets/terms_and_conditions.dart';
import '../../../../network_services/repository/user_repository/user_repo.dart';
import '../../../Authentication Models/signup/view_model/signup_provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '876537161505-00feg181hqinbt5em1ppmjhv09bbrf9m.apps.googleusercontent.com',
    scopes: scopes,
  );

  @override
  void initState() {
    SingUpProvider provider =
        Provider.of<SingUpProvider>(context, listen: false);
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
      print('${account!.email}');
      print('${account.id}');
      print('${account.photoUrl}');
      print('${account.displayName}');
      Map<String, dynamic> map = {
        'first_name': '${account.displayName}',
        'last_name': '',
        'email': '${account.email}',
      };
      provider.social_login(context: context, map: map);
      _handleSignOut();
    });
    super.initState();
  }

  Future<void> _handleSignIn() async {
    print('Clicked');
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  @override
  void deactivate() {
    if (mounted) {
      final SingUpProvider provider =
          Provider.of<SingUpProvider>(context, listen: false);
      provider.emailController.text = '';
      provider.passwordController.text = '';
      provider.phoneController.text = '';
      provider.loading = false;
      provider.liceince = null;
      provider.logo = null;
      provider.country_code = '+971';
      provider.company_type = 'Osaka';
      provider.isVisible = false;
      provider.index = 2;
      provider.companyTypeName = null;
    }
    super.deactivate();
  }

  bool email_error = false;
  ValueNotifier<bool> termAndConditionNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final SingUpProvider provider = Provider.of<SingUpProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DataLoading(
        isLoading: provider.loading,
        child: Scaffold(
          backgroundColor:
              //Colors.black,
              Color(0xff181F30),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 6.h,
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
                          'Create Account!'.tr,
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
                    padding: EdgeInsets.only(left: 6.w),
                    child: Text(
                      'Enter the information to create an Account'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  //if(index == 1)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: CustommTextField(
                          controller: provider.firstNameController,
                          prefixIcon: 'assets/email.svg',
                          hintText: 'First name'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter First name'.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: CustommTextField(
                          controller: provider.lastNameController,
                          prefixIcon: 'assets/email.svg',
                          hintText: 'Last name'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Last name'.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
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
                          onChange: (v) async {
                            var result = await UserRepository.instance
                                .check_duplicate(
                                    body: {"email": "$v", "account_type": 1});
                            if (result['message'] ==
                                "Account is not available") {
                              email_error = true;
                              setState(() {});
                            } else {
                              email_error = false;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      if (email_error)
                        Row(
                          children: [
                            SizedBox(
                              width: 8.w,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                'Email is already exist.'.tr,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      provider.isPending == true ? 2.2.h : 0),
                              child: Container(
                                height: 6.2.h,
                                width: 26.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17)),
                                child: IntlPhoneField(
                                  controller: provider.phoneController,
                                  focusNode: provider.focusNode,
                                  disableAutoFillHints: false,
                                  disableLengthCheck: true,
                                  showDropdownIcon: false,
                                  //enabled: false,
                                  flagsButtonMargin:
                                      EdgeInsets.only(left: 3.w, top: 0.3.h),
                                  decoration: InputDecoration(
                                    // hintText: 'Phone Number',
                                    // hintStyle: TextStyle(fontSize: 10.sp,color: Color(0xff181F30)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(17)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    disabledBorder: InputBorder.none,
                                    //contentPadding: EdgeInsets.only(bottom: 2.h),
                                  ),

                                  languageCode: "en",
                                  onCountryChanged: (country) {
                                    provider.country_code =
                                        '+' + country.fullCountryCode;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 0.5.h),
                              child: CustommTextField(
                                hintText: 'Mobile Number'.tr,
                                controller: provider.phoneController,
                                validator: (value) {
                                  provider.isPending = true;
                                  provider.updateState();
                                  if (value!.isEmpty) {
                                    return 'Please enter mobile number'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: CustommTextField(
                          controller: provider.passwordController,
                          prefixIcon: 'assets/lock.svg',
                          hintText: 'password'.tr,
                          visible: !provider.isPasswordShow,
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (provider.isPasswordShow) {
                                provider.isPasswordShow = false;
                              } else {
                                provider.isPasswordShow = true;
                              }
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                              //color: provider.!isPasswordShow ? Colors.grey[500] : blueGrey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password'.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: termAndConditionNotifier,
                              builder: (c, v, child) {
                                if (termAndConditionNotifier.value) {
                                  return InkWell(
                                    onTap: () {
                                      termAndConditionNotifier.value =
                                          !termAndConditionNotifier.value;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 2.5.h,
                                      width: 5.w,
                                      child: SvgPicture.asset(
                                          color: Color(0xffFFD542),
                                          'assets/svgs/check_circle.svg'),
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    termAndConditionNotifier.value =
                                        !termAndConditionNotifier.value;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 2.5.h,
                                    width: 5.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: Color(0xffFFD542),
                                        )),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'I herby accept all the  '.tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Terms & Condition'.tr,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xffFFD542),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9.5.sp),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            // final Uri url = Uri.parse(
                                            //     'https://sarya.app/terms.html');
                                            // if (!await launchUrl(url)) {
                                            //   throw Exception(
                                            //       'Could not launch');
                                            // }
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TermsAndConditions(
                                                    isFromSignUp: false,
                                                  ),
                                                ));
                                          }),
                                    TextSpan(
                                        text: ' \n& ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9.5.sp,
                                            fontWeight: FontWeight.w500),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {}),
                                    TextSpan(
                                        text: 'Privacy Policy'.tr,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xffFFD542),
                                            fontSize: 9.5.sp,
                                            fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            // //modelBottomSheet();
                                            // final Uri url = Uri.parse(
                                            //     'https://sarya.app/privacy.html');
                                            // if (!await launchUrl(url)) {
                                            //   throw Exception(
                                            //       'Could not launch');
                                            // }
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TermsAndConditions(
                                                    isFromSignUp: false,
                                                  ),
                                                ));
                                          })
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      if (provider.isVisible == true &&
                          !termAndConditionNotifier.value)
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 1.h),
                              child: Text(
                                'Accept Terms and Condition'.tr,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              ),
                            )),
                      SizedBox(
                        height: 4.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (email_error == false &&
                              termAndConditionNotifier.value) {
                            terms_condition_dialog(
                                context: context,
                                on_done: () {
                                  provider.call_sign_up(formKey);
                                });
                          } else {
                            print('object1');
                            provider.isVisible = true;
                            setState(() {});
                          }
                        },
                        child: CustomButton(
                          text: 'Next',
                          borderColor: Color(0xffFFD542),
                          textColor: Color(0xff181F30),
                          buttonColor: Color(0xffFFD542),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?'.tr,
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LogInScreen(),
                                    ));
                              },
                              child: Text(
                                ' Sign In'.tr,
                                style: TextStyle(
                                  color: Color(0xffFFD542),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         height: 0.12.h,
                      //         width: 30.w,
                      //         color: Colors.white,
                      //       ),
                      //       Text(
                      //         '  Or Sign in with  ',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //       Container(
                      //         height: 0.12.h,
                      //         width: 28.w,
                      //         color: Colors.white,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 5.h,
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                      //   child: InkWell(
                      //     onTap: () {
                      //       _handleSignIn();
                      //     },
                      //     child: CustomGoogleButton(
                      //         image: 'assets/google.png',
                      //         text: 'Signup with Google'),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 2.5.h,
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                      //   child: CustomGoogleButton(
                      //       image: 'assets/facebook.png',
                      //       text: 'Signup with Facebook'),
                      // ),
                      // SizedBox(
                      //   height: 4.h,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     //Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(),));
          //   },
          // ),
        ),
      ),
    );
  }

  terms_condition_dialog({BuildContext? context, Function()? on_done}) {
    showMaterialModalBottomSheet(
      context: context!,
      backgroundColor: Color(0xffFFD542).withOpacity(0.5),
      builder: (context) => Container(
          color: Color(0xffFFD542).withOpacity(0.5),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 35.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(children: [
                  Container(
                    height: 7.5.h,
                    child: Center(
                        child: Text(
                      'Terms and Conditions'.tr,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    )),
                    decoration: BoxDecoration(
                        color: Color(0xffD1E3F4),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                      child: Text(
                    'I agree to share my details and i have read Terms\n and Condition, Privacy Policy.'.tr,
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 6.h,
                    width: 100.w,
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            'Cancel'.tr,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      )),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          on_done!.call();
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            'Agree'.tr,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      )),
                    ]),
                  )
                ]),
              ),
            ],
          )),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yellowline/global_widgets/custom_google_button.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';
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
                          'Create Account!',
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
                      'Enter the information to create an Account',
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
                          hintText: 'First name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter First name';
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
                          hintText: 'Last name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Last name';
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
                          hintText: 'Email',
                          validator: (value) {
                            bool? v = provider.validate_email_phone(value);
                            if (v == false) {
                              return 'Please enter email';
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
                                'Email is already exist.',
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
                                hintText: 'Mobile Number',
                                controller: provider.phoneController,
                                validator: (value) {
                                  provider.isPending = true;
                                  provider.updateState();
                                  if (value!.isEmpty) {
                                    return 'Please enter mobile number';
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
                          hintText: 'password',
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
                              return 'Please enter password';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (email_error == false) {
                            provider.call_sign_up(formKey);
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
                              'Already have an account?',
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
                                ' Sign In',
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Row(
                          children: [
                            Container(
                              height: 0.12.h,
                              width: 30.w,
                              color: Colors.white,
                            ),
                            Text(
                              '  Or Sign in with  ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              height: 0.12.h,
                              width: 28.w,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: InkWell(
                          onTap: () {
                            _handleSignIn();
                          },
                          child: CustomGoogleButton(
                              image: 'assets/google.png',
                              text: 'Signup with Google'),
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: CustomGoogleButton(
                            image: 'assets/facebook.png',
                            text: 'Signup with Facebook'),
                      )
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
}

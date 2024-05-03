import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_google_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import 'package:yellowline/view/screens/authentication/forgot_password_screen/forgot_password_screen.dart';
import 'package:yellowline/view/screens/authentication/signup_screen/signup_screen.dart';
import '../../../Authentication Models/login/view_model/login_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class _LogInScreenState extends State<LogInScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '876537161505-00feg181hqinbt5em1ppmjhv09bbrf9m.apps.googleusercontent.com',
    scopes: scopes,
  );

  @override
  void initState() {
    LoginProvider provider = Provider.of<LoginProvider>(context, listen: false);
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
  Widget build(BuildContext context) {
    final LoginProvider provider = Provider.of<LoginProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DataLoading(
        isLoading: provider.loading,
        child: Scaffold(
          backgroundColor: Color(0xff181F30),
          //Colors.black,
          body: SingleChildScrollView(
            child: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Row(
                      children: [
                        Text(
                          'Welcome Back!',
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
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Row(
                      children: [
                        Text(
                          'Enter your credentials to continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  // Container(
                  //   // height: 4.h,
                  //   width: 45.w,
                  //   padding: EdgeInsets.all(1),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(width: 0.5,color: Colors.white),
                  //       borderRadius: BorderRadius.circular(7),
                  //       color: Colors.white
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             index = 1;
                  //             setState(() {
                  //
                  //             });
                  //           },
                  //           child: Container(
                  //             height: 3.9.h,
                  //             //width: 22.w,
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(width: 0.5,color: Colors.white),
                  //                 borderRadius: BorderRadius.circular(7),
                  //                 color: index == 1? Color(0xffFFD542):Colors.white
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 'User',
                  //                 style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 10.sp
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             index = 2;
                  //             setState(() {
                  //
                  //             });
                  //           },
                  //           child: Container(
                  //             height: 3.9.h,
                  //             //width: 22.2.w,
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(width: 0.5,color: Colors.white),
                  //                 borderRadius: BorderRadius.circular(7),
                  //                 color: index == 2? Color(0xffFFD542):Colors.white
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 'Business',
                  //                 style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 10.sp
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: CustommTextField(
                      controller: provider.emailController,
                      prefixIcon: 'assets/emails.svg',
                      hintText: 'Email',
                      validator: (value) {
                        bool? v = provider.validate_email_phone(value);
                        if (v == false) {
                          return 'Please enter email';
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
                      controller: provider.passwordController,
                      prefixIcon: 'assets/password.svg',
                      visible: !provider.isPasswordShow,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        } else {
                          return null;
                        }
                      },
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
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ));
                          },
                          child: Text(
                            'Forgot Password?',
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
                  GestureDetector(
                    onTap: () {
                      provider.login_api(context);
                      // if(provider.formKey.currentState!.validate()){
                      //   print('object');
                      // }
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                    },
                    child: CustomButton(
                      text: 'Sign In',
                      borderColor: Colors.black,
                      textColor: Colors.black,
                      buttonColor: Color(0xffFFD542),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Do not have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                          },
                          child: Text(
                            ' Signup',
                            style: TextStyle(
                              color: Color(0xffFFD542),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         height: 0.12.h,
                  //         width: 38.w,
                  //         color: Colors.white,
                  //       ),
                  //       Text(
                  //         '  OR  ',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       Container(
                  //         height: 0.12.h,
                  //         width: 39.w,
                  //         color: Colors.white,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 3.h,
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
                  //   height: 2.h,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                  //   child: CustomGoogleButton(
                  //       image: 'assets/facebook.png',
                  //       text: 'Signup with Facebook'),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

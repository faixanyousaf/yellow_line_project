import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_google_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/Business%20Screens/Business%20Home%20Page/business_home_screen.dart';
import 'package:yellowline/view/screens/authentication/forgot_password_screen/forgot_password_screen.dart';
import 'package:yellowline/view/screens/authentication/signup_screen/signup_screen.dart';

class BusinessLoginScreen extends StatefulWidget {
  const BusinessLoginScreen({Key? key}) : super(key: key);

  @override
  State<BusinessLoginScreen> createState() => _BusinessLoginScreenState();
}

class _BusinessLoginScreenState extends State<BusinessLoginScreen> {
  int index = 2;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      //Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 6.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            //SizedBox(height: 1.h,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 6.w),
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
            SizedBox(height: 4.h,),
            Container(
              // height: 4.h,
              width: 45.w,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5,color: Colors.white),
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        index = 1;
                        setState(() {

                        });
                      },
                      child: Container(
                        height: 3.9.h,
                        //width: 22.w,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.white),
                            borderRadius: BorderRadius.circular(7),
                            color: index == 1? Color(0xffFFD542):Colors.white
                        ),
                        child: Center(
                          child: Text(
                            'Driver',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        index = 2;
                        setState(() {

                        });
                      },
                      child: Container(
                        height: 3.9.h,
                        //width: 22.2.w,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.white),
                            borderRadius: BorderRadius.circular(7),
                            color: index == 2? Color(0xffFFD542):Colors.white
                        ),
                        child: Center(
                          child: Text(
                            'Business',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 4.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: emailController,
                prefixIcon: 'assets/emails.svg',
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: passwordController,
                prefixIcon: 'assets/password.svg',
                suffixIcon: 'assets/eyes.svg',
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
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
            SizedBox(height: 4.h,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessHomeScreen(),));
              },
              child: CustomButton(
                text: 'Sign In',
                borderColor: Colors.black,
                textColor: Colors.black,
                buttonColor: Color(0xffFFD542),
              ),
            ),
            SizedBox(height: 1.5.h,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do not have an account?',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(id: 2),));
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
            SizedBox(height: 3.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                children: [
                  Container(height: 0.12.h,width: 38.w,color: Colors.white,),
                  Text(
                    '  OR  ',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Container(height: 0.12.h,width: 39.w,color: Colors.white,),
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustomGoogleButton(image: 'assets/google.png',text: 'Signup with Google'),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustomGoogleButton(image: 'assets/facebook.png',text: 'Signup with Facebook'),
            )
          ],
        ),
      ),
    );
  }
}

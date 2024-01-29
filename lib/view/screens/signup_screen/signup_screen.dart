import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yellowline/global_widgets/custom_google_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int index = 1;
  TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 6.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 2.h,),
                  SizedBox(width: 3.w,),
                  Text(
                    'Create Account!',
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
              child: Text(
                'Enter the information to create an Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    //fontWeight: FontWeight.bold
                ),
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
                  GestureDetector(
                    onTap: () {
                      index = 1;
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 3.9.h,
                      width: 22.w,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5,color: Colors.white),
                          borderRadius: BorderRadius.circular(7),
                          color: index == 1? Color(0xffFFD542):Colors.white
                      ),
                      child: Center(
                        child: Text(
                          'User',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      index = 2;
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 3.9.h,
                      width: 22.2.w,
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
                  )
                ],
              ),
            ),
            SizedBox(height: 4.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: emailController,
                prefixIcon: 'assets/email.svg',
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Container(
                height: 9.h,
                //width: 98.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17)
                ),
                child: IntlPhoneField(
                  focusNode: focusNode,
                  disableAutoFillHints: false,
                  disableLengthCheck: false,
                  showDropdownIcon: false,
                  flagsButtonMargin: EdgeInsets.only(left: 4.w,top: 0.3.h),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(fontSize: 10.sp,color: Color(0xff181F30)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
                    fillColor: Colors.white,
                    filled: true,
                    disabledBorder: InputBorder.none,
                    //contentPadding: EdgeInsets.only(bottom: 2.h),
                  ),

                  languageCode: "en",
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
              ),
            ),
            SizedBox(height: 4.h,),
            CustomButton(
              text: 'Next',
              borderColor: Colors.black,
              textColor: Colors.black,
              buttonColor: Color(0xffFFD542),
            ),
            SizedBox(height: 1.5.h,),
            RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    TextSpan(
                        text: ' Sign In',
                        style: TextStyle(
                            color: Color(0xffFFD542),
                        )
                    )
                  ]
                )
            ),
            SizedBox(height: 3.h,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              children: [
                Container(height: 0.12.h,width: 30.w,color: Colors.white,),
                Text(
                  '  Or Sign in with  ',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                Container(height: 0.12.h,width: 30.w,color: Colors.white,),
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
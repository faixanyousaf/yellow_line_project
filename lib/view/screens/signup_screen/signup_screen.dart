import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int index = 1;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              SizedBox(height: 6.h,),
              Row(
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
              //SizedBox(height: 1.h,),
              Text(
                'Enter the information to create an Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    //fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 4.h,),
              Container(
                height: 4.h,
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
              CustommTextField(
                controller: emailController,
                prefixIcon: 'assets/email.svg',
                hintText: 'Email',
              )
              // Container(
              //   height: 6.5.h,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(17)
              //   ),
              //   child: TextField(
              //     style: TextStyle(fontSize: 12.sp),
              //     controller: emailController,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
              //         hintText: 'Email',
              //         labelStyle: TextStyle(fontSize: 10.sp,color: Colors.grey),
              //         hintStyle: TextStyle(fontSize: 9.sp,color: Color(0xff181F30)),
              //         fillColor: Colors.white,
              //         filled: true,
              //         // suffixIcon: Padding(
              //         //   padding:  EdgeInsets.only(left: 1.w,top: 2.8.h,bottom: 2.5.h,right: 5.w),
              //         //   child: SvgPicture.asset('assets/email.svg',height: 2.h,),
              //         // ),
              //         //suffixIconColor: appColor,
              //         //iconColor: appColor,
              //         prefixIcon: Padding(
              //           padding:  EdgeInsets.only(left: 3.w,top: 2.8.h,bottom: 2.5.h,right: 2.w),
              //           child: SvgPicture.asset('assets/email.svg',height: 2.h,),
              //         ),
              //         contentPadding: EdgeInsets.only(left: 2.w,right: 2.w,bottom: 1.5.h),
              //         disabledBorder: InputBorder.none,
              //         //focusedBorder: InputBorder.none,
              //         //enabledBorder: InputBorder.none
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

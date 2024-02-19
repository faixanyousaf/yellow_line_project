import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';

class BusinessSignUpScreen extends StatefulWidget {
  const BusinessSignUpScreen({Key? key}) : super(key: key);

  @override
  State<BusinessSignUpScreen> createState() => _BusinessSignUpScreenState();
}

class _BusinessSignUpScreenState extends State<BusinessSignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox(height: 2.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: CustommTextField(
            controller: emailController,
            prefixIcon: 'assets/svgs/company_icon.svg',
            hintText: 'Company Name',
            //suffixIcon: 'assets/eyes.svg',
          ),
        ),
        SizedBox(height: 2.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: CustommTextField(
            controller: emailController,
            prefixIcon: 'assets/email.svg',
            hintText: 'Email',
            //suffixIcon: 'assets/eyes.svg',
          ),
        ),
        SizedBox(height: 2.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Row(
            children: [
              Container(
                height: 6.2.h,
                width: 26.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17)
                ),
                child: IntlPhoneField(
                  controller: phoneController,
                  focusNode: focusNode,
                  disableAutoFillHints: false,
                  disableLengthCheck: true,
                  showDropdownIcon: false,
                  //enabled: false,
                  flagsButtonMargin: EdgeInsets.only(left: 3.w,top: 0.3.h),
                  decoration: InputDecoration(
                    // hintText: 'Phone Number',
                    // hintStyle: TextStyle(fontSize: 10.sp,color: Color(0xff181F30)),
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
              SizedBox(width: 2.w,),
              Expanded(
                  child: Padding(
                    padding:  EdgeInsets.only(top: 0.5.h),
                    child: CustommTextField(
                      hintText: 'Mobile Number',
                      controller: phoneController,
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(height: 2.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/svgs/compan.svg',height: 1.5.h,),
                        SizedBox(width: 2.w,),
                        Text(
                          'Choose company type',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    'Registration card',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Container(
                    height: 12.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Container(
                        height: 5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: Color(0xffFFD542),
                            shape: BoxShape.circle
                        ),
                        child: Center(child: SvgPicture.asset('assets/svgs/arro.svg',height: 2.3.h,)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 23.w,),
              Column(
                children: [
                  Text(
                    'Company Logo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Container(
                    width: 30.w,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 11.h,
                            width: 25.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/svgs/company_icon.svg',height: 4.5.h,),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2.w,
                          right: 4.5.w,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFFD542),
                                shape: BoxShape.circle
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: Icon(Icons.camera_alt,color: Colors.black,size: 1.7.h,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h,),
        CustomButton(
          text: 'Next',
          borderColor: Color(0xffFFD542),
          textColor: Color(0xff181F30),
          buttonColor: Color(0xffFFD542),
        ),
        SizedBox(height: 2.h,),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
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
        SizedBox(height: 4.h,),
      ],
    );
  }
}

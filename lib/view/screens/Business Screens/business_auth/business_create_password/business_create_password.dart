import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/Business%20Screens/Business%20Login/business_login_screen.dart';

class BusinessCreatePassword extends StatefulWidget {
  const BusinessCreatePassword({Key? key}) : super(key: key);

  @override
  State<BusinessCreatePassword> createState() => _BusinessCreatePasswordState();
}

class _BusinessCreatePasswordState extends State<BusinessCreatePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

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
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 2.h,)),
                  SizedBox(width: 3.w,),
                  Text(
                    'Create Password!',
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
              padding:EdgeInsets.symmetric(horizontal: 13.w),
              child: Row(
                children: [
                  Text(
                    'Create your Account Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: passwordController,
                prefixIcon: 'assets/password.svg',
                hintText: 'Enter your password',
                suffixIcon: 'assets/eyes.svg',
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: conformPasswordController,
                prefixIcon: 'assets/password.svg',
                suffixIcon: 'assets/eyes.svg',
                hintText: 'Confirm your password',
              ),
            ),
            SizedBox(height: 10.h,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessLoginScreen(),));
              },
              child: CustomButton(
                text: 'Create',
                borderColor: Colors.black,
                textColor: Colors.black,
                buttonColor: Color(0xffFFD542),
              ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessLoginScreen(),));
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
            SizedBox(height: 3.h,),
          ],
        ),
      ),
    );
  }
}

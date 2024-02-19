import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/driver_home_screen.dart';
import 'package:yellowline/view/screens/authentication/forgot_password_screen/forgot_password_screen.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({Key? key}) : super(key: key);

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  int index = 1;
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
                          'Driver',
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
            CustomButton(
              text: 'Sign In',
              borderColor: Colors.black,
              textColor: Colors.black,
              buttonColor: Color(0xffFFD542),
            ),
            SizedBox(height: 1.5.h,),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHomeScreen(),));
        },
      ),
    );
  }
}

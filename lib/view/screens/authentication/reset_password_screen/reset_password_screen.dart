import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';
import 'package:yellowline/view/screens/home_page/home_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                    'Reset Password!',
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
                    'Reset your Account Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: passwordController,
                prefixIcon: 'assets/password.svg',
                hintText: 'Enter new password',
                // suffixIcon: IconButton(
                //   onPressed: () {
                //     if (provider.isPasswordShow) {
                //       provider.isPasswordShow = false;
                //     } else {
                //       provider.isPasswordShow = true;
                //     }
                //     setState(() {});
                //   },
                //   icon: const Icon(
                //     Icons.remove_red_eye,
                //     //color: provider.!isPasswordShow ? Colors.grey[500] : blueGrey,
                //   ),
                // ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: conformPasswordController,
                prefixIcon: 'assets/password.svg',
                // suffixIcon: IconButton(
                //   onPressed: () {
                //     if (provider.isPasswordShow) {
                //       provider.isPasswordShow = false;
                //     } else {
                //       provider.isPasswordShow = true;
                //     }
                //     setState(() {});
                //   },
                //   icon: const Icon(
                //     Icons.remove_red_eye,
                //     //color: provider.!isPasswordShow ? Colors.grey[500] : blueGrey,
                //   ),
                // ),
                hintText: 'Confirm new password',
              ),
            ),
            SizedBox(height: 8.h,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
              },
              child: CustomButton(
                text: 'Reset',
                borderColor: Color(0xffFFD542),
                textColor: Color(0xff181F30),
                buttonColor: Color(0xffFFD542),
              ),
            ),
            SizedBox(height: 1.5.h,),

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      //   },
      // ),
    );
  }
}

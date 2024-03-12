import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import 'package:yellowline/view/screens/authentication/forgot_password_screen/Forget%20Provider/reset_password_provider.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';
import 'package:yellowline/view/screens/home_page/home_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  String? email;
  String? sendOtp;
   ResetPasswordScreen({Key? key,this.email,this.sendOtp}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {


  @override
  Widget build(BuildContext context) {
    final ResetPasswordProvider provider = Provider.of<ResetPasswordProvider>(context);
    return DataLoading(
      isLoading: provider.loading,
      child: Scaffold(
        backgroundColor: Color(0xff181F30),
        //Colors.black,
        body: SingleChildScrollView(
          child: Form(
            key: provider.formKey,
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
                    controller: provider.passwordController,
                    prefixIcon: 'assets/password.svg',
                    hintText: 'Enter new password',
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
                    controller: provider.resetPasswordController,
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
                    visible: !provider.isPasswordShow1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (provider.isPasswordShow1) {
                          provider.isPasswordShow1 = false;
                        } else {
                          provider.isPasswordShow1 = true;
                        }
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        //color: provider.!isPasswordShow ? Colors.grey[500] : blueGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h,),
                GestureDetector(
                  onTap: () async{
                    await provider.reset_password_api_function(
                      email: widget.email,
                      otp: widget.sendOtp
                    );
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
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
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        //   },
        // ),
      ),
    );
  }
}

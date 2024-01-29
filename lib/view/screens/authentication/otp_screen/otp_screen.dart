import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yellowline/view/screens/authentication/create_password_screen/create_password_screen.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();

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
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 2.h,)),
                  SizedBox(width: 3.w,),
                  Text(
                    'Verify OTP',
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
              child: Text(
                'Enter OTP verification code received at your ‘’+971 555066435’’',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 4.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6.w),
              child: PinCodeTextField(
                appContext: context,
                hintCharacter: '-',
                hintStyle: TextStyle(fontSize: 13.sp,color: Colors.black),
                pastedTextStyle: TextStyle(
                  color: Color(0xff8381E0),
                  fontWeight: FontWeight.bold,
                ),
                length: 6,

                // obscureText: true,
                // obscuringCharacter: '*',
                //  obscuringWidget: const FlutterLogo(
                //    size: 24,
                //  ),
                //blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                // validator: (v) {
                //   if (v!.length < 3) {
                //     return "I'm from validator";
                //   } else {
                //     return null;
                //   }
                // },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeColor: Color(0xff8381E0),
                  inactiveColor: Color(0xff8381E0).withAlpha(100),
                  selectedFillColor: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  fieldHeight: 6.h,
                  fieldWidth: 13.w,
                  // fieldWidth: 25.w,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                // cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                //errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                // boxShadows: const [
                //   BoxShadow(
                //     offset: Offset(0, 1),
                //     color: Colors.black12,
                //     blurRadius: 10,
                //   )
                // ],
                onCompleted: (v) {
                  debugPrint("Completed");
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  // debugPrint(value);
                  // setState(() {
                  //   currentText = value;
                  // });
                  setState(() {});
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
            SizedBox(height: 14.h,),
            CustomButton(
              text: 'Verify',
              borderColor: Colors.black,
              textColor: Colors.black,
              buttonColor: Color(0xffFFD542),
            ),
            SizedBox(height: 1.5.h,),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePasswordScreen(),));
        },
      ),
    );
  }
}

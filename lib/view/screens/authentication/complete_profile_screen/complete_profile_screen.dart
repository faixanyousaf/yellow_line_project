import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  int index = 1;

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
                    'Complete Profile!'.tr,
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
                    'We need some more information to\ncomplete your profile'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h,),
            Container(
              width: 30.w,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 17.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Image(image: AssetImage('assets/profile.png'),height: 7.h,),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.w,
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
            SizedBox(height: 2.h,),
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
                        height: 3.5.h,
                        //width: 22.w,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.white),
                            borderRadius: BorderRadius.circular(7),
                            color: index == 1? Color(0xffFFD542):Colors.white
                        ),
                        child: Center(
                          child: Text(
                            'Male'.tr,
                            style: TextStyle(
                                color: Color(0xff181F30),
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
                        height: 3.5.h,
                        //width: 22.2.w,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.white),
                            borderRadius: BorderRadius.circular(7),
                            color: index == 2? Color(0xffFFD542):Colors.white
                        ),
                        child: Center(
                          child: Text(
                            'Female'.tr,
                            style: TextStyle(
                                color: Color(0xff181F30),
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
            SizedBox(height: 6.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: firstNameController,
                prefixIcon: 'assets/name.svg',
                hintText: 'First Name'.tr,
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: lastNameController,
                prefixIcon: 'assets/name.svg',
                hintText: 'Last Name'.tr,
              ),
            ),
            SizedBox(height: 12.h,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
              },
              child: CustomButton(
                text: 'Finish'.tr,
                borderColor: Color(0xffFFD542),
                textColor: Color(0xff181F30),
                buttonColor: Color(0xffFFD542),
              ),
            ),
            SizedBox(height: 1.5.h,),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
        },
      ),
    );
  }
}

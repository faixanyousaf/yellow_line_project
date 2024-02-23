import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_textfield.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_detail_screen.dart';

class UpdateDriverScreen extends StatefulWidget {
  const UpdateDriverScreen({Key? key}) : super(key: key);

  @override
  State<UpdateDriverScreen> createState() => _UpdateDriverScreenState();
}

class _UpdateDriverScreenState extends State<UpdateDriverScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        //toolbarHeight: 9.h,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,)),
        title: Text(
          'Update Driver',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        actions: [
          Image(image: AssetImage('assets/bells.png')),
          SizedBox(width: 3.w,),
          Padding(
            padding:  EdgeInsets.only(right: 6.w),
            child: Container(
              height: 7.h,
              width: 5.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(width: 0.6,color: Colors.white)
              ),
              child: Center(
                child: Icon(Icons.person,color: Colors.white,size: 3.w,),
              ),
            ),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6.w),
              child: Container(
                height: 3.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.redAccent,
                ),
                child: Center(
                  child: Text(
                    'Upload a clear Government ID image',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: firstNameController,
                prefixIcon: 'assets/name.svg',
                hintText: 'First Name',
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CustommTextField(
                controller: lastNameController,
                prefixIcon: 'assets/name.svg',
                hintText: 'Last Name',
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
                          hintText: 'Company Mobile Number',
                          controller: phoneController,
                        ),
                      ))
                ],
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
                  driverContainer(text: 'Driving License'),
                  SizedBox(width: 24.w,),
                  driverContainer(text: 'Government ID')
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                children: [
                  driverContainer(text: 'Passport/Visa'),
                  SizedBox(width: 24.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Driver picture',
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
                            shape: BoxShape.circle
                          //borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Image(image: AssetImage('assets/drvrimg.png')),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            CustomButton(
              buttonColor: Color(0xffFFD542),
              borderColor: Color(0xffFFD542),
              text: 'Update',
              textColor: Color(0xff181F30),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleDetailScreen(),));
      //   },
      // ),
    );
  }

  Widget driverContainer({String? text}){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text!,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/add_driver_screen/update_driver_screen.dart';

class DriverApprovelScreen extends StatefulWidget {
  const DriverApprovelScreen({Key? key}) : super(key: key);

  @override
  State<DriverApprovelScreen> createState() => _DriverApprovelScreenState();
}

class _DriverApprovelScreenState extends State<DriverApprovelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 28.h,),
              Container(
                height: 25.h,
                width: 35.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff424755),
                ),
                child: Center(
                  child: Image(image: AssetImage('assets/driver.png'),height: 10.h,),
                ),
              ),
              //SizedBox(height: 1.h,),
              Text(
                'Driver Added Successfully',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    //fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 0.5.h,),
              Text(
                '& waiting for Approval',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  //fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 27.h,),
              CustomButton(
                borderColor: Color(0xffFFCC1B),
                buttonColor: Color(0xffFFCC1B),
                textColor: Color(0xff181F30),
                text: 'Ok',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateDriverScreen(),));
        },
      ),
    );
  }
}

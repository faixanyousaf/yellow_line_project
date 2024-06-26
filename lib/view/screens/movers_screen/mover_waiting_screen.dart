import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/movers_screen/quotations_screen.dart';

class MoverWaitingScreen extends StatefulWidget {
  const MoverWaitingScreen({Key? key}) : super(key: key);

  @override
  State<MoverWaitingScreen> createState() => _MoverWaitingScreenState();
}

class _MoverWaitingScreenState extends State<MoverWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.h,),
              Container(
                height: 25.h,
                width: 35.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff424755),
                ),
                child: Center(
                  child: Image(image: AssetImage('assets/clock1.png'),height: 23.h,),
                ),
              ),
              //SizedBox(height: 1.h,),
              Text(
                'Waiting for Quotations'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp
                ),
              ),
              SizedBox(height: 30.h,),
              CustomButton(
                borderColor: Color(0xffFFCC1B),
                buttonColor: Color(0xffFFCC1B),
                textColor: Colors.black,
                text: 'View'.tr,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => QuotationsScreen(),));
        },
      ),
    );
  }
}

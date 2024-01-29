import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/recovery_screens/live_tracking_screen.dart';

class RecoveryConfirmedScreen extends StatefulWidget {
  const RecoveryConfirmedScreen({Key? key}) : super(key: key);

  @override
  State<RecoveryConfirmedScreen> createState() => _RecoveryConfirmedScreenState();
}

class _RecoveryConfirmedScreenState extends State<RecoveryConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  child: Image(image: AssetImage('assets/trucks.png'),height: 7.h,),
                ),
              ),
              //SizedBox(height: 1.h,),
              Text(
                'Recovery Request Confirmed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp
                ),
              ),
              SizedBox(height: 32.h,),
              CustomButton(
                borderColor: Color(0xffFFCC1B),
                buttonColor: Color(0xffFFCC1B),
                textColor: Colors.black,
                text: 'Track',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LiveTrackingScreen(),));
        },
      ),
    );
  }
}

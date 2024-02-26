import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/movers_screen/request_home_screen.dart';

class MoverConfirmScreen extends StatefulWidget {
  const MoverConfirmScreen({Key? key}) : super(key: key);

  @override
  State<MoverConfirmScreen> createState() => _MoverConfirmScreenState();
}

class _MoverConfirmScreenState extends State<MoverConfirmScreen> {
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
                  child: Image(image: AssetImage('assets/truk.png'),height: 7.h,),
                ),
              ),
              //SizedBox(height: 1.h,),
              Text(
                'Mover Request Confirmed',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp
                ),
              ),
              SizedBox(height: 30.h,),
              CustomButton(
                borderColor: Color(0xffFFCC1B),
                buttonColor: Color(0xffFFCC1B),
                textColor: Color(0xff181F30),
                text: 'Track',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RequestHomeScreen(),));
        },
      ),
    );
  }
}

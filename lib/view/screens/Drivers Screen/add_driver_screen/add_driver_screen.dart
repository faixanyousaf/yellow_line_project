import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/add_driver_screen/driver_list_screen.dart';

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({Key? key}) : super(key: key);

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,)),
        title: Text(
          'My Driver',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 5.w),
            child: Row(
              children: [
                Image(image: AssetImage('assets/bells.png')),
                SizedBox(width: 3.w,),
                Container(
                  height: 4.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(width: 0.6,color: Colors.white)
                  ),
                  child: Center(
                    child: Icon(Icons.person,color: Colors.white,size: 3.w,),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15.h,),
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
                'No Drivers Added',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 0.5.h,),
              Text(
                'Please click the below button to',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
              Text(
                'add a Driver',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 25.h,),
              CustomButton(
                borderColor: Color(0xffFFCC1B),
                buttonColor: Color(0xffFFCC1B),
                textColor: Color(0xff181F30),
                text: 'Add New Driver',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverListScreen(),));
        },
      ),
    );
  }
}

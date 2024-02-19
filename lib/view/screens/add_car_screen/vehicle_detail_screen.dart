import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_added_sceen.dart';

class VehicleDetailScreen extends StatefulWidget {
  const VehicleDetailScreen({Key? key}) : super(key: key);

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
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
          'Add New Vehicles',
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
                  height: 5.h,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            typeContainer('Type', 'Choose vehicle type'),
            typeContainer('Make', 'Choose company'),
            typeContainer('Model', 'Choose vehicle model'),
            typeContainer('Year', 'Choose Year'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                'Registration card',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Container(
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
            ),
            SizedBox(height: 14.h,),
            CustomButton(
              buttonColor: Color(0xffFFD542),
              borderColor: Color(0xffFFD542),
              text: 'Add',
              textColor: Color(0xff181F30),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleAddedScreen(),));
        },
      ),
    );
  }

  Widget typeContainer(String? title, String? text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(
            title!,
            style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp
            ),
          ),
        ),
        SizedBox(height: 1.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h,)
      ],
    );
  }

}

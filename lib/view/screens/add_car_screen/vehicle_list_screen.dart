import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/add_car_screen/add_new_vehicle_screen.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({Key? key}) : super(key: key);

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
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
          'My Vehicles',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        actions: [
          // Padding(
          //   padding:  EdgeInsets.only(right: 5.w),
          //   child: Row(
          //     children: [
          //       Image(image: AssetImage('assets/bells.png')),
          //       SizedBox(width: 3.w,),
          //       Container(
          //         height: 4.h,
          //         width: 5.w,
          //         decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.black,
          //             border: Border.all(width: 0.6,color: Colors.white)
          //         ),
          //         child: Center(
          //           child: Icon(Icons.person,color: Colors.white,size: 3.w,),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
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
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 9.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 8.w,),
                      Text(
                        '18',
                        style: TextStyle(
                          color: Color(0xff181F30),
                          fontSize: 16.sp
                        ),
                      ),
                      SizedBox(width: 25.w,),
                      Image(image: AssetImage('assets/abu_dhabi.png',),height: 7.5.h,),
                      SizedBox(width: 10.w,),
                      Text(
                        '66435',
                        style: TextStyle(
                            color: Color(0xff181F30),
                            fontSize: 16.sp
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 9.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 8.w,),
                      Text(
                        'AB',
                        style: TextStyle(
                            color: Color(0xff181F30),
                            fontSize: 16.sp
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      Image(image: AssetImage('assets/dubai.png'),width: 25.w,),
                      SizedBox(width: 3.w,),
                      Text(
                        '66435',
                        style: TextStyle(
                            color: Color(0xff181F30),
                            fontSize: 16.sp
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 53.h,),
            CustomButton(
              buttonColor: Color(0xffFFD542),
              borderColor: Color(0xffFFD542),
              text: 'Add New Vehicle',
              textColor: Color(0xff181F30),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewVehicleScreen(),));
        },
      ),
    );
  }
}

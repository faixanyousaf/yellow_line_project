import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_list_screen.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,),
        title: Text(
          'My Vehicles',
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
                Stack(
                  children: [
                    Image(image: AssetImage('assets/bells.png')),
                    Positioned(
                      top: 0,
                      left: 1.5.w,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            '1',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 6.sp
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  child: Image(image: AssetImage('assets/carss.png'),height: 7.h,),
                ),
              ),
              //SizedBox(height: 1.h,),
              Text(
                'No Vehicles Added',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 0.5.h,),
              Text(
                'Please click the below button to\n          add your vehicle',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 28.h,),
              CustomButton(
                borderColor: Color(0xffFFCC1B),
                buttonColor: Color(0xffFFCC1B),
                textColor: Colors.black,
                text: 'Add New Vehicle',
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleListScreen(),));
        },
      ),
    );
  }
}

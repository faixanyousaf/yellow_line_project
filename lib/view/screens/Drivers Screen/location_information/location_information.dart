import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/global_widgets/custom_drop_conatiner.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/driver_active_home_screen/driver_active_home_screen.dart';

class LocationInformation extends StatefulWidget {
  const LocationInformation({Key? key}) : super(key: key);

  @override
  State<LocationInformation> createState() => _LocationInformationState();
}

class _LocationInformationState extends State<LocationInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 90.h,
                width: 100.w,
                child: Image(image: AssetImage('assets/google_map.png'),fit: BoxFit.cover,),
              ),
            ],
          ),
          Positioned(
            top: 7.h,
            left: 5.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
                  child: Row(
                    children: [
                      Image(image: AssetImage('assets/New Notification.png'),height: 2.7.h,),
                      SizedBox(width: 1.w,),
                      Text(
                        'New job has been assigned. Start immediately!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),),
          Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                    color: Color(0xff181F30),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Text(
                        'Location Information:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      height: 5.3.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        children: [
                          CustomDropContainer(
                            height: 5.2.h,
                            width: 30.w,
                            text: 'Distance',
                            texxt: '9 km',
                          ),
                          SizedBox(width: 2.w,),
                          CustomDropContainer(
                            height: 5.2.h,
                            width: 30.w,
                            text: 'Time to reach',
                            texxt: '10 mins',
                          ),
                          SizedBox(width: 2.w,),
                          Image(image: AssetImage('assets/WA.png')),
                          SizedBox(width: 2.w,),
                          Image(image: AssetImage('assets/PN.png'))
                        ],
                      ),
                    ),
                    // Row(
                    //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     dropContainer(textt: 'Reaching in',text: '10 mins'),
                    //     SizedBox(width: 3.w,),
                    //     dropContainer(textt: 'Distance',text: '9 km'),
                    //
                    //   ],
                    // ),

                    SizedBox(height: 2.h,),
                    CustomButton(
                      text: 'Start',
                      borderColor: Colors.black,
                      textColor: Colors.black,
                      buttonColor: Color(0xffFFD542),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverActiveHomeScreen(),));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/driver_drawer.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/location_information/location_information.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  final _controller = ValueNotifier<bool>(false);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xff181F30),
        child: DriverDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.w),
            child: Image(image: AssetImage('assets/menu.png'),),
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 5.w),
            child: Row(
              children: [
                Image(image: AssetImage('assets/bells.png')),
                SizedBox(width: 3.w,),
                SvgPicture.asset('assets/svgs/homeicon.svg'),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 1.h,),
              Container(
                height: 4.h,
                width: 35.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 5.w,),
                      Text(
                        'I am online',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9.sp
                        ),
                      ),
                      SizedBox(width: 4.w,),
                      AdvancedSwitch(
                        controller: _controller,
                        activeColor: Colors.green,
                        //Colors.green,
                        inactiveColor: Colors.grey,
                        width: 7.w,
                        height: 2.h,
                        enabled: true,
                        disabledOpacity: 0.5,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              Container(
                height: 20.h,
                child: Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => JobsScreen(),));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Center(
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 3.h,),
                                Image(image: AssetImage('assets/folder.png'),width: 11.w,),
                                SizedBox(height: 3.h,),
                                Text(
                                  'Total Jobs',
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black
                                  ),
                                ),
                                //SizedBox(height: 1.h,),
                                Text(
                                  '34',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(height: 2.h,),
              Container(
                height: 20.h,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.h,),
                                Image(image: AssetImage('assets/folder.png'),width: 11.w,),
                                SizedBox(height: 2.h,),
                                Text(
                                  'Completed',
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black
                                  ),
                                ),
                                //SizedBox(height: 1.h,),
                                Text(
                                  '46',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.h,),
                                Image(image: AssetImage('assets/folder.png'),width: 11.w,),
                                SizedBox(height: 2.h,),
                                Text(
                                  'Active',
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black
                                  ),
                                ),
                                //SizedBox(height: 1.h,),
                                Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Container(
                height: 30.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales Statistics',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Expanded(
                          child: Container(
                            //width: 80.w,
                              child: Image(
                                image: AssetImage('assets/chart.png'),fit: BoxFit.cover,))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LocationInformation(),));
        },
      ),
    );
  }
}

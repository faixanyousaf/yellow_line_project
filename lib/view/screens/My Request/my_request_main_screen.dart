import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/add_driver_screen/add_driver_screen.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_list_screen.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_screen.dart';

import 'movers_screen.dart';

class MyRequestMainScreen extends StatefulWidget {
  const MyRequestMainScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestMainScreen> createState() => _MyRequestMainScreenState();
}

class _MyRequestMainScreenState extends State<MyRequestMainScreen>with SingleTickerProviderStateMixin {
  late TabController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        leading: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w),
          child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 4.w,),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            'My Request',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp
            ),
          ),
        ),
        leadingWidth: 2.w,
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: 2.h,),
            Container(
              child: TabBar(
                indicatorColor: Color(0xffFFCC1B),
                controller: _controller,
                dividerColor: Color(0xff283a68),
                unselectedLabelColor: Color(0xffEDEDED),
                labelColor: Color(0xffFFCC1B),
                indicatorWeight: 0.1.h,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.8.h),
                    child: Text(
                      'Recovery',
                      style: TextStyle(
                          //color: Color(0xffFFCC1B),
                          fontSize: 10.sp ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.8.h),
                    child: Text(
                      'Movers',
                      style: TextStyle(
                          //color: Color(0xffFFCC1B),
                          fontSize: 10.sp ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.8.h),
                    child: Text(
                      'Rentals',
                      style: TextStyle(
                          //color: Color(0xffFFCC1B),
                          fontSize: 10.sp ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: const [
                    SizedBox(),
                    MoversScreen(),
                    SizedBox(),
                  ],
                )
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleScreen(),));
        },
      ),

    );
  }
}

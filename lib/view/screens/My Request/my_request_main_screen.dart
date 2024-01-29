import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios,color: Colors.white),
        title: Text('My Requests',style: TextStyle(color: Colors.white,fontSize: 18)),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: 4.h,),
            Container(
              child: TabBar(
                indicatorColor: Color(0xffFFCC1B),
                controller: _controller,
                dividerColor: Color(0xff283a68),
                unselectedLabelColor: Colors.grey.shade200,
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.5.h),
                    child: Text(
                      'Recovery',
                      style: TextStyle(color: Color(0xffFFCC1B),fontSize: 12.sp ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.5.h),
                    child: Text(
                      'Movers',
                      style: TextStyle(color: Color(0xffFFCC1B),fontSize: 12.sp ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.5.h),
                    child: Text(
                      'Rentals',
                      style: TextStyle(color: Color(0xffFFCC1B),fontSize: 12.sp ),
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
      )
    );
  }
}

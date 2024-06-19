import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'movers_screen.dart';

class MyRequestMainScreen extends StatefulWidget {
  const MyRequestMainScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestMainScreen> createState() => _MyRequestMainScreenState();
}

class _MyRequestMainScreenState extends State<MyRequestMainScreen>
    with SingleTickerProviderStateMixin {
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
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 4.w,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            'My Requests'.tr,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              child: TabBar(
                indicatorColor: Color(0xffFFCC1B),
                controller: _controller,
                dividerColor: Colors.white,
                unselectedLabelColor: Color(0xffEDEDED),
                labelColor: Color(0xffFFCC1B),
                indicatorWeight: 0.2.h,
                dividerHeight: 0.2.h,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.8.h),
                    child: Text(
                      'Active'.tr,
                      style: TextStyle(
                          //color: Color(0xffFFCC1B),
                          fontSize: 10.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.8.h),
                    child: Text(
                      'Cancelled'.tr,
                      style: TextStyle(
                          //color: Color(0xffFFCC1B),
                          fontSize: 10.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.8.h),
                    child: Text(
                      'Completed'.tr,
                      style: TextStyle(
                          //color: Color(0xffFFCC1B),
                          fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: _controller,
              children: const [
                MoversScreen(
                  status: 1,
                ),
                MoversScreen(
                  status: 2,
                ),
                MoversScreen(
                  status: 4,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

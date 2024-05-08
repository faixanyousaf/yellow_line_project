import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yellowline/view/screens/My%20Request/view/my_request_main_screen.dart';
import 'package:yellowline/view/screens/home_page/drawer_screen.dart';

class TrackingHomeScreen extends StatefulWidget {
  const TrackingHomeScreen({Key? key}) : super(key: key);

  @override
  State<TrackingHomeScreen> createState() => _TrackingHomeScreenState();
}

class _TrackingHomeScreenState extends State<TrackingHomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int activePage = 0;
  final List<Widget> pages = [
    // Padding(
    //   padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
    //   child: Image(image: AssetImage('assets/car.png'),height: 23.h,),
    // ),
    // Image(image: AssetImage('assets/car.png'),height: 28.h,),
    // Image(image: AssetImage('assets/car.png'),height: 28.h,),
    Positioned(
      top: 13.h,
      left: 15.w,
      child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/car.png'),height: 28.h,),

              ],
            ),
          )
      ),
    ),
    Positioned(
      top: 13.h,
      left: 15.w,
      child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/car.png'),height: 28.h,),

              ],
            ),
          )
      ),
    ),
    Positioned(
      top: 13.h,
      left: 15.w,
      child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/car.png'),height: 28.h,),

              ],
            ),
          )
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      //Colors.black,
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xff181F30),
        child: DrawerScreen(),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 9.h),
              child: Image(image: AssetImage('assets/background.png'),fit: BoxFit.cover,),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 5.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Image(image: AssetImage('assets/menu.png'))),
                      Row(
                        children: [
                          Image(image: AssetImage('assets/bells.png'),height: 5.h,),
                          SizedBox(width: 2.w,),
                          Container(
                              height: 9.h,
                              width: 9.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  border: Border.all(color: Colors.white,width: 1)
                              ),
                              child: Icon(Icons.person,color: Colors.white,))
                        ],
                      )
                    ],
                  ),
                  //SizedBox(height: 1.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome, Faizan Yousaf'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        height: 4.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: Color(0xffFC7C56),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'SOS',
                            style: TextStyle(color: Colors.white,fontSize: 13.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                  //SizedBox(height: 2.h,),
                  Container(
                    height: 40.h,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (value) {
                            setState(() {
                              activePage = value;
                            });
                          },
                          itemCount: pages.length,
                          itemBuilder: (context, index) {
                            return pages[index% pages.length];
                          },),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 5.h,
                          child: Center(
                            child: SmoothPageIndicator(
                              count: pages.length,
                              controller: _pageController,
                              effect: ExpandingDotsEffect(
                                  dotColor: Colors.white,
                                  dotHeight: 1.h,
                                  dotWidth: 2.w,
                                  activeDotColor: Colors.white,
                                  //strokeWidth: 5.w,
                                  expansionFactor: 1.1.w
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 2.h,),
                      Text(
                        'Choose a Service'.tr,
                        style: TextStyle(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3.h,),
                      Container(
                        height: 20.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                  height: 19.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff181F30),
                                    //Colors.black
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 3.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 2.h,),
                                        Container(
                                          height: 6.h,
                                          width: 12.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Image(image: AssetImage('assets/truck_recovery.png'),),
                                          ),
                                        ),
                                        SizedBox(height: 3.h,),
                                        Expanded(
                                          child: Text(
                                            'Vehicle Movers'.tr,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.sp,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.5.w,),
                              ],
                            );
                          },),
                      ),
                      SizedBox(height: 4.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 5.h,
                              width: 33.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Color(0xffFFD542)
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(width: 2.w,),
                                    Image(image: AssetImage('assets/act.png'),height: 3.h,),
                                    SizedBox(width: 4.w,),
                                    Text(
                                      'Tracking'.tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h,),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyRequestMainScreen(),));
        },
      ),
    );
  }

  Widget customListTile({String? image, String? text}){
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(image!),
                    height: 3.8.h,
                  ),
                  SizedBox(width: 5.w,),
                  Text(
                    text!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios_rounded,size: 4.w,color: Colors.white,),
            ],
          ),
        ),
        SizedBox(height: 3.h,)
      ],
    );
  }
}

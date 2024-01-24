import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/home_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int activePage = 0;
  final List<Widget> pages = [
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 8.h,),
              Container(
                height: 60.h,
                child: Stack(
                  children: [
                    Image(image: AssetImage('assets/background.png'),fit: BoxFit.cover,),
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
                        bottom: 10.h,
                        left: 0,
                        right: 0,
                        height: 5.h,
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(pages.length, (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: InkWell(
                                onTap: () {
                                  _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                                },
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor:activePage == index?
                                  Colors.green
                                      :Colors.grey,
                                ),
                              ),
                            ),),
                          ),
                        )
                    )
                    // Positioned(
                    //   top: 13.h,
                    //   left: 15.w,
                    //   child: Container(
                    //       child: Center(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Image(image: AssetImage('assets/car.png'),height: 28.h,),
                    //
                    //           ],
                    //         ),
                    //       )
                    //   ),
                    // ),

                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 7.h,
            left: 4.w,
            child: Image(image: AssetImage('assets/menu.png')),
          ),
          Positioned(
            top: 7.h,
            right: 17.w,
            child: Image(image: AssetImage('assets/bells.png'),height: 5.h,),
          ),
          Positioned(
            top: 5.h,
            right: 6.w,
            child: Container(
                height: 9.h,
                width: 9.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white,width: 1)
                ),
                child: Icon(Icons.person,color: Colors.white,)),
          ),
          Positioned(
            top: 15.h,
            left: 5.w,
            child: Text(
              'Welcome to, Faizan Yousaf',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: 14.h,
            right: 5.w,
            child: Container(
              height: 4.h,
              width: 20.w,
              decoration: BoxDecoration(
                color: Color(0xffFC7C56),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'SOS',
                  style: TextStyle(color: Colors.white,fontSize: 13.sp),
                ),
              ),
            ),
          ),
          Positioned(
            top: 15.5.w,
            right: 18.w,
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
          // Positioned(
          //     child: Container()
          // ),
          Positioned(
            bottom: 0,
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    children: [
                      SizedBox(height: 2.h,),
                      Text(
                        'Choose a Service',
                        style: TextStyle(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeContainer(
                            image: 'assets/truck.png',
                            text: 'Vehicle\nRecovery',
                          ),
                          //SizedBox(width: 2.6.w,),
                          HomeContainer(
                            image: 'assets/movers.png',
                            text: 'Vehicle\nMovers',
                          ),
                          //SizedBox(width: 2.6.w,),
                          HomeContainer(
                            image: 'assets/machine.png',
                            text: 'Rental\nEquipments',
                          )

                        ],
                      ),
                      SizedBox(height: 4.h,),
                      Container(
                        height: 7.h,
                        decoration: BoxDecoration(
                          color: Color(0xffFFD542),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/cars.png'),width: 8.w,),
                              SizedBox(width: 7.w,),
                              Text(
                                'Add a Car',
                                style: TextStyle(color: Colors.black,fontSize: 12.sp,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h,),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}

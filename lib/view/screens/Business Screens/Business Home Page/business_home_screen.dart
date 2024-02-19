import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/view/screens/Business%20Screens/Jobs%20Screen/jobs_screen.dart';

class BusinessHomeScreen extends StatefulWidget {
  const BusinessHomeScreen({Key? key}) : super(key: key);

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        leading: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.w),
          child: Image(image: AssetImage('assets/menu.png'),),
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
              SizedBox(height: 2.h,),
              Container(
                //height: 5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff424755),
                ),
                child: Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.5.h),
                    child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Your account is under approval but in the meantime you can still add ',
                              style: TextStyle(color: Colors.white,fontSize: 10.sp)
                            ),
                            TextSpan(
                                text: ' Vehicles & Drivers',
                                style: TextStyle(color: Color(0xffFFCC1B),fontSize: 10.sp)
                            )
                          ]
                        )
                    ),
                  ),
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
                                SizedBox(height: 1.h,),
                                Text(
                                  'Vehicles',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black
                                  ),
                                ),
                                //SizedBox(height: 1.h,),
                                Text(
                                  '20',
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
                                SizedBox(height: 1.h,),
                                Text(
                                  'Drivers',
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black
                                  ),
                                ),
                                //SizedBox(height: 1.h,),
                                Text(
                                  '45',
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
                height: 20.h,
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => JobsScreen(),));
                          },
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
                                  SizedBox(height: 3.h,),
                                  Image(image: AssetImage('assets/folder.png'),width: 11.w,),
                                  SizedBox(height: 3.h,),
                                  Text(
                                    'Jobs',
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
                        )
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Center(
                                    child: Row(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //SizedBox(width: 1.w,),
                                        Image(image: AssetImage('assets/folder.png'),width: 11.w,),
                                        SizedBox(width: 3.w,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Completed',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.black
                                              ),
                                            ),
                                            //SizedBox(height: 1.h,),
                                            Text(
                                              '34',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Center(
                                    child: Row(
                                     // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //SizedBox(width: 4.w,),
                                        Image(image: AssetImage('assets/folder.png'),width: 11.w,),
                                        SizedBox(width: 3.w,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Active',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.black
                                              ),
                                            ),
                                            //SizedBox(height: 1.h,),
                                            Text(
                                              '34',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => JobsScreen(),));
      //   },
      // ),
    );
  }
}

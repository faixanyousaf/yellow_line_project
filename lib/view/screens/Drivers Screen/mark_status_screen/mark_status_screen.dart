import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/home_page/tracking_home_screen.dart';

class MarkStatusScreen extends StatefulWidget {
  const MarkStatusScreen({Key? key}) : super(key: key);

  @override
  State<MarkStatusScreen> createState() => _MarkStatusScreenState();
}

class _MarkStatusScreenState extends State<MarkStatusScreen> {
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
            left: 3.w,
            child: Icon(Icons.arrow_back_ios,color: Colors.white,),),
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
                        'Mark Status:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 6.w),
                      child: Container(
                        //height: 15.h,
                        //width: widget.width,
                        decoration: BoxDecoration(
                          color: Color(0xff424755),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 3.w,),
                          child: Column(
                            children: [
                              SizedBox(height: 2.h,),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svgs/marked.svg'),
                                  SizedBox(width: 2.w,),
                                  Text(
                                    'Arrived at Pick-up Point',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.sp
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 2.h,),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svgs/unmark.svg'),
                                  SizedBox(width: 2.w,),
                                  Text(
                                    'Started for Destination',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.sp
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 2.h,),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svgs/unmark.svg'),
                                  SizedBox(width: 2.w,),
                                  Text(
                                    'Reached at Destination',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.sp
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 2.h,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    CustomButton(
                      text: 'Done',
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingHomeScreen(),));
        },
      ),
    );
  }
}

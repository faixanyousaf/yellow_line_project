import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class ActiveScreen extends StatefulWidget {
  const ActiveScreen({Key? key}) : super(key: key);

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100.h,
      width: 100.w,
      child: ListView.builder(
        itemCount: 4,
        padding: EdgeInsets.only(top: 2.h),
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              //height: 13.h,
              width: 100.w,
              child: Stack(
                children: [
                  Center(
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [6],
                      radius: Radius.circular(20),
                      //color: Color(0xff8381E0),
                      strokeWidth: 1.3,
                      color: Color(0xffFFCC1B),
                      // strokeCap: StrokeCap.butt,
                      //strokeWidth: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          //height: 13.h,
                          width: 85.w,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height:0.3.h,),
                                 Text('19 Jan, 2024',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.white)),
                                 Text('AED 2000',style: TextStyle(fontSize: 10.sp,color: Color(0xff13F01C))),
                                SizedBox(height: 0.5.h,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svgs/dot.svg'),
                                    SizedBox(width: 2.w,),
                                    Text('Saddar, Rawalpindi',style: TextStyle(fontSize: 8.sp,color: Colors.white)),
                                  ],
                                ),
                                SizedBox(height: 1.h,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svgs/locy.svg'),
                                    SizedBox(width: 2.w,),
                                    Text('Bahria Phase 7, Rawalpindi',style: TextStyle(fontSize: 8.sp,color: Colors.white)),
                                  ],
                                ),
                                SizedBox(height: 1.3.h,)
                              ],
                            ),
                          ),
                        ),
                      ),),
                  ),
                  Positioned(
                      right: 3.w,
                      top: 4.5.h,
                      child: SvgPicture.asset('assets/svgs/yellow_arrrow.svg')),
                ],
              ),
            ),
            SizedBox(height: 2.h,)
          ],
        ),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuotationsScreen extends StatefulWidget {
  const QuotationsScreen({Key? key}) : super(key: key);

  @override
  State<QuotationsScreen> createState() => _QuotationsScreenState();
}

class _QuotationsScreenState extends State<QuotationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 4.w,),
        title: Text(
          'Quotations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              SizedBox(height: 1.h,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ABC Movers',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8.sp
                            ),
                          ),
                          Text(
                            'AED 600',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      //SizedBox(height: 1.h,),
                      Text(
                        '2 hours to reach',
                        style: TextStyle(
                            color: Color(0xff5A5A5A),
                            fontSize: 7.sp
                        ),
                      ),
                      SizedBox(height:1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                height: 4.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xffEDEDED),
                                ),
                                child: Center(
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 9.sp
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          SizedBox(width: 3.w,),
                          Expanded(
                            child: Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xffFFD542),
                              ),
                              child: Center(
                                child: Text(
                                  'Accept & Pay',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.5.h,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ABC Movers',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8.sp
                            ),
                          ),
                          Text(
                            'AED 600',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      //SizedBox(height: 1.h,),
                      Text(
                        '2 hours to reach',
                        style: TextStyle(
                            color: Color(0xff5A5A5A),
                            fontSize: 7.sp
                        ),
                      ),
                      SizedBox(height:1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xffEDEDED),
                              ),
                              child: Center(
                                child: Text(
                                  'Reject',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w,),
                          Expanded(
                            child: Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xffFFD542),
                              ),
                              child: Center(
                                child: Text(
                                  'Accept & Pay',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

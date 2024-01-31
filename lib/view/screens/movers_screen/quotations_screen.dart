import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../RENTAL EQUIPMENTS/rental_screen.dart';

class QuotationsScreen extends StatefulWidget {
  const QuotationsScreen({Key? key}) : super(key: key);

  @override
  State<QuotationsScreen> createState() => _QuotationsScreenState();
}

class _QuotationsScreenState extends State<QuotationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RentalEquipments(),));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 4.w,)),
        title: Text(
          'Quotations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          children: [
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
                              color: Color(0xff181F30),
                              fontSize: 10.sp
                          ),
                        ),
                        Text(
                          'AED 600',
                          style: TextStyle(
                              color: Color(0xff181F30),
                              fontSize: 11.sp,
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
                          fontSize: 8.5.sp
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
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffEDEDED),
                            ),
                            child: Center(
                              child: Text(
                                'Reject',
                                style: TextStyle(
                                    color: Color(0xff181F30),
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
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffFFCC1B),
                            ),
                            child: Center(
                              child: Text(
                                'Accept & Pay',
                                style: TextStyle(
                                    color: Color(0xff181F30),
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
            SizedBox(height: 1.5.h,)
          ],
        ),
        );
      },)

    );
  }
}

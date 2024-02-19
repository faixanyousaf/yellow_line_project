import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/Drivers%20Screen/add_driver_screen/add_new_driver.dart';

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({Key? key}) : super(key: key);

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        //toolbarHeight: 9.h,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,)),
        title: Text(
          'My Driver',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        actions: [
          Image(image: AssetImage('assets/bells.png')),
          SizedBox(width: 3.w,),
          Padding(
            padding:  EdgeInsets.only(right: 6.w),
            child: Container(
              height: 7.h,
              width: 5.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(width: 0.6,color: Colors.white)
              ),
              child: Center(
                child: Icon(Icons.person,color: Colors.white,size: 3.w,),
              ),
            ),
          )

        ],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 8.h,
              width: 100.w,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      //height: 9.h,
                      width: 89.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: 3.w,),
                            Container(
                              height: 5.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: Image(
                                image: AssetImage('assets/drivers.png'),
                              ),
                            ),
                            SizedBox(width: 2.w,),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 0.5.h),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Faizan Yousaf',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      '0555066435',
                                      style: TextStyle(
                                          color: Color(0xff181F30),
                                          fontSize: 9.sp
                                      ),
                                    ),
                                    Text(
                                      'Online',
                                      style: TextStyle(
                                          color: Color(0xff0CC243),
                                          fontSize: 9.sp
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 3.w,
                      top: 2.h,
                      child: SvgPicture.asset('assets/svgs/yellow_arrrow.svg')),
                ],
              ),
            ),
            SizedBox(height: 2.h,)
          ],
        );
      },),
      bottomNavigationBar: Container(
        height: 11.h,
        color: Color(0xff181F30),
        child: Column(
          children: [
            SizedBox(height: 2.h,),
            CustomButton(
              buttonColor: Color(0xffFFD542),
              borderColor: Color(0xffFFD542),
              text: 'Add New Driver',
              textColor: Color(0xff181F30),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewDriverScreen(),));
        },
      ),
    );
  }
}

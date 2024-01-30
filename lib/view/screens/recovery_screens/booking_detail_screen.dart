import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/bottom_button.dart';
import 'package:yellowline/global_widgets/custom_drop_conatiner.dart';
import 'package:yellowline/view/screens/recovery_screens/recovery_confirmed_screen.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 80.h,
                width: 100.w,
                child: Image(image: AssetImage('assets/google_map.png'),fit: BoxFit.cover,),
              ),
            ],
          ),
          Positioned(
            top: 7.h,
            left: 3.w,
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,),),
          Positioned(
            top: 11.h,
            left: 5.w,
            child: Container(
              height: 5.h,
              width: 44.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(width: 2.w,),
                    Image(image: AssetImage('assets/location.png'),height: 2.h,),
                    SizedBox(width: 3.w,),
                    Text(
                      'Pickup Location',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp
                      ),
                    ),
                    SizedBox(width: 9.w,),
                    SvgPicture.asset('assets/remove.svg'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 11.h,
            right: 5.w,
            child: Container(
              height: 5.h,
              width: 44.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(width: 2.w,),
                    Image(image: AssetImage('assets/location.png'),height: 2.h,),
                    SizedBox(width: 3.w,),
                    Text(
                      'Drop-off Location',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    SvgPicture.asset('assets/remove.svg'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h,),
                      Text(
                        'Booking Details:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        height: 5.5.h,
                        child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CustomDropContainer(
                              height: 5.4.h,
                              width: 20.w,
                              text: 'Time',
                              texxt: '35 mins',
                            ),
                          ),),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     dropContainer(textt: 'Time',text: '35 mins'),
                      //     dropContainer(textt: 'Distance',text: '19 km'),
                      //     dropContainer(textt: 'Price',text: '450 AED'),
                      //     dropContainer(textt: 'Type',text: 'Normal'),
                      //   ],
                      // ),
                      SizedBox(height: 2.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 0.5.h),
                            child: Text(
                              'Payment Method',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w,),
                          Container(
                            // height: 4.h,
                            width: 45.w,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5,color: Colors.white),
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    index = 1;
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    height: 3.2.h,
                                    width: 22.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5,color: Colors.white),
                                        borderRadius: BorderRadius.circular(7),
                                        color: index == 1? Color(0xffFFD542):Colors.white
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Cash',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9.sp
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    index = 2;
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    height: 3.2.h,
                                    width: 22.2.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5,color: Colors.white),
                                        borderRadius: BorderRadius.circular(7),
                                        color: index == 2? Color(0xffFFD542):Colors.white
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Card',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9.sp
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBottomButton(
                            text: 'Cancel',
                            buttonColor: Colors.black,
                            textColor: Color(0xffFFCC1B),
                            borderColor: Color(0xffFFCC1B),
                          ),
                          CustomBottomButton(
                            text: 'Confirm',
                            buttonColor: Color(0xffFFCC1B),
                            textColor: Colors.black,
                            borderColor: Colors.black,
                          )
                        ],
                      ),
                      SizedBox(width: 2.w,),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecoveryConfirmedScreen(),));
        },
      ),
    );
  }

}

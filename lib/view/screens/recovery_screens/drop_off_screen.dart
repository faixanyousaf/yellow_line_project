import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/bottom_button.dart';
import 'package:yellowline/view/screens/recovery_screens/booking_detail_screen.dart';

class DropOffScreen extends StatefulWidget {
  const DropOffScreen({Key? key}) : super(key: key);

  @override
  State<DropOffScreen> createState() => _DropOffScreenState();
}

class _DropOffScreenState extends State<DropOffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
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
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,)),),
            Positioned(
              top: 11.h,
              left: 5.w,
              child: Container(
                height: 5.h,
                width: 44.w,
                decoration: BoxDecoration(
                  color: Color(0xff181F30),
                  //Colors.black,
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
                  color: Color(0xff181F30),
                  //Colors.black,
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
                    color: Color(0xff181F30),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          'Drop-off Suggestions:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        height: 7.h,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          itemBuilder: (context, index) => Row(
                            children: [
                              dropContainer(image: 'assets/garage.png',text: 'Garage'),
                              SizedBox(width: 2.w,)
                            ],
                          ),),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     dropContainer(image: 'assets/garage.png',text: 'Garage'),
                      //     dropContainer(image: 'assets/service.png',text: 'Service\nStation'),
                      //     dropContainer(image: 'assets/pump.png',text: 'Petrol\nPump'),
                      //   ],
                      // ),
                      SizedBox(height: 1.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          'Recovery Type',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        height: 3.5.h,
                        child:  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          itemBuilder: (context, index) => Row(
                            children: [
                              Container(
                              height: 2.8.h,
                              //width: 22.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(width: 0.7,color: Colors.white)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                  child: Text(
                                    'Normal',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.sp
                                    ),
                                  ),
                                ),
                              ),
                              ),
                              SizedBox(width: 2.3.w,)

                            ],
                          ),),
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 2.8.h,
                      //       width: 22.w,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(30),
                      //         border: Border.all(width: 0.7,color: Colors.white)
                      //       ),
                      //       child: Center(
                      //         child: Text(
                      //           'Normal',
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 8.sp
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 2.w,),
                      //     Container(
                      //       height: 2.8.h,
                      //       width: 22.w,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(30),
                      //           border: Border.all(width: 0.7,color: Colors.white)
                      //       ),
                      //       child: Center(
                      //         child: Text(
                      //           'Sports',
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 8.sp
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 2.w,),
                      //     Container(
                      //       height: 2.8.h,
                      //       width: 22.w,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(30),
                      //           border: Border.all(width: 0.7,color: Colors.white)
                      //       ),
                      //       child: Center(
                      //         child: Text(
                      //           'Heavy',
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 8.sp
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBottomButton(
                              text: 'Schedule',
                              buttonColor: Color(0xff181F30),
                              textColor: Color(0xffFFCC1B),
                              borderColor: Color(0xffFFCC1B),
                            ),
                            CustomBottomButton(
                                text: 'Continue',
                                buttonColor: Color(0xffFFCC1B),
                                textColor: Colors.black,
                                borderColor: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h,),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailScreen(),));
        },
      ),
    );
  }

  Widget dropContainer({String? image, String? text}){
    return Container(
      height: 6.3.h,
      width: 28.6.w,
      decoration: BoxDecoration(
        color: Color(0xff424755),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(width: 2.w,),
            Image(image: AssetImage(image!),height: 3.h,),
            SizedBox(width: 2.w,),
            Text(
              text!,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/bottom_button.dart';
import 'package:yellowline/global_widgets/custom_drop_conatiner.dart';
import 'package:yellowline/view/screens/movers_screen/apartment_detail_screen.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({Key? key}) : super(key: key);

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
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
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,)),),
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
                        'Live Tracking:'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      height: 5.3.h,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        itemBuilder: (context, index) => Row(
                          children: [
                            CustomDropContainer(
                              height: 5.2.h,
                              width: 28.w,
                              text: 'Reaching in'.tr,
                              texxt: '10 mins',
                            ),
                            SizedBox(width: 3.w,)
                          ],
                        ),),
                    ),
                    // Row(
                    //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     dropContainer(textt: 'Reaching in',text: '10 mins'),
                    //     SizedBox(width: 3.w,),
                    //     dropContainer(textt: 'Distance',text: '9 km'),
                    //
                    //   ],
                    // ),

                    SizedBox(height: 2.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBottomButton(
                            text: 'WhatsApp',
                            buttonColor: Color(0xff0CC243),
                            textColor: Colors.white,
                            borderColor: Color(0xff0CC243),
                          ),
                          CustomBottomButton(
                            text: 'Call'.tr,
                            buttonColor: Color(0xffFFCC1B),
                            textColor: Color(0xff181F30),
                            borderColor: Color(0xffFFCC1B),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ApartmentDetailScreen(),));
        },
      ),
    );
  }


}

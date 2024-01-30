import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/bottom_button.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_screen.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({Key? key}) : super(key: key);

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
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
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 5.w,),),
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
                        'Live Tracking:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        height: 5.3.h,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: dropContainer(textt: 'Reaching in',text: '10 mins'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBottomButton(
                            text: 'WhatsApp',
                            buttonColor: Color(0xff0CC243),
                            textColor: Colors.white,
                            borderColor: Color(0xff0CC243),
                          ),
                          CustomBottomButton(
                            text: 'Call',
                            buttonColor: Color(0xffFFCC1B),
                            textColor: Colors.black,
                            borderColor: Color(0xffFFCC1B),
                          )
                        ],
                      ),
                      SizedBox(width: 2.h,),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleScreen(),));
        },
      ),
    );
  }

  Widget dropContainer({String? textt, String? text}){
    return Container(
      height: 5.2.h,
      width: 28.w,
      decoration: BoxDecoration(
        color: Color(0xff424755),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textt!,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 8.sp
              ),
            ),
            Text(
              text!,
              //maxLines: 2,
              style: TextStyle(
                  color: Color(0xffFFCC1B),
                  fontSize: 8.sp
              ),
            )
          ],
        ),
      ),
    );
  }

}

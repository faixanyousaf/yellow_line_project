import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:sizer/sizer.dart';

class DriverDrawer extends StatefulWidget {
  const DriverDrawer({Key? key}) : super(key: key);

  @override
  State<DriverDrawer> createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer> {
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 6.5.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 4.w,)),
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Container(
              width: 30.w,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 17.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(width: 0.8,color: Colors.white)
                      ),
                      child: Center(
                        child: Icon(Icons.person,size: 9.h,color: Colors.white,),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.w,
                    right: 4.5.w,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFFD542),
                          shape: BoxShape.circle
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.camera_alt,color: Colors.black,size: 1.7.h,),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //SizedBox(height: 1.h,),
            Text(
              'Faizan Yousaf',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold
              ),
            ),
            //SizedBox(height: 1.h,),
            Text(
              'faizan@gmail.com',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.sp,
              ),
            ),
            SizedBox(height: 4.h,),
            //customListTile(text: 'My Vehicle',image: 'assets/vehicle.png'),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 3.8.h,
                        width: 7.4.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color(0xffFFCC1B)
                        ),
                        child: Center(
                          child: Image(
                            image: AssetImage('assets/online.png'),
                            height: 2.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text(
                        'Online',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  AdvancedSwitch(
                    controller: _controller,
                    activeColor: Colors.green,
                    //Colors.green,
                    inactiveColor: Colors.grey,
                    width: 7.w,
                    height: 2.h,
                    enabled: true,
                    disabledOpacity: 0.5,
                  )
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 3.8.h,
                        width: 7.4.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color(0xffFFCC1B)
                        ),
                        child: Center(
                          child: Image(
                            image: AssetImage('assets/request.png'),
                            height: 2.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text(
                        'My Jobs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,size: 4.w,color: Colors.white,),
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            customListTile(text: 'Notifications',image: 'assets/notification.png'),
            //SizedBox(height: 21.h,),

          ],
        ),
        Positioned(
          bottom: 3.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
          height: 4.h,
          width: 30.w,
          decoration: BoxDecoration(
                color: Color(0xffFF3E3E),
                borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/logout.png'),color: Colors.white,height: 2.h,),
                  SizedBox(width: 4.w,),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
          ),
        ),
            )
        )
      ],
    );
  }

  Widget customListTile({String? image, String? text}){
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(image!),
                    height: 3.8.h,
                  ),
                  SizedBox(width: 5.w,),
                  Text(
                    text!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios_rounded,size: 4.w,color: Colors.white,),
            ],
          ),
        ),
        SizedBox(height: 3.h,)
      ],
    );
  }

}

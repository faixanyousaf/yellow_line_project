import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/navigation/navigation_object.dart';
import '../../../helper/navigation/router_path.dart';
import '../../../helper/shared_prefs.dart';
import '../../Authentication Models/login/models/login_Responce_model.dart';
import '../authentication/login_screen/login_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    get_user_data();
    super.initState();
  }

  LoginResponceModel? loginResponceModel;
  get_user_data() async {
    SharedPrefs sf = SharedPrefs();
    var user = await sf.getUser();
    loginResponceModel = LoginResponceModel.fromJson(user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 6.5.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    size: 4.w,
                  )),
              Text(
                'Edit',
                style: TextStyle(fontSize: 10.sp, color: Color(0xffFFCC1B)),
              )
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          height: 11.h,
          width: 22.w,
          decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              border: Border.all(width: 0.8, color: Colors.white)),
          child: Center(
            child: Icon(
              Icons.person,
              size: 9.h,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        if (loginResponceModel != null)
          Text(
            '${loginResponceModel!.user!.first_name} ${loginResponceModel!.user!.last_name}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
        //SizedBox(height: 1.h,),
        if (loginResponceModel != null)
          Text(
            '${loginResponceModel!.user!.email}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.sp,
            ),
          ),
        SizedBox(
          height: 4.h,
        ),
        InkWell(
            onTap: () {
              navigationService.navigateTo(RouterPath.Vehicle_List_Screen);
            },
            child: customListTile(
                text: 'My Vehicle', image: 'assets/vehicle.png')),
        InkWell(
          onTap: (){
           navigationService.navigateTo(RouterPath.request_view_screen);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                          color: Color(0xffFFCC1B)),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/request.png'),
                          height: 2.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      'My Request',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 4.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        customListTile(text: 'Notifications', image: 'assets/notification.png'),
        customListTile(text: 'Wallet', image: 'assets/wallet.png'),
        customListTile(text: 'Business Account', image: 'assets/account.png'),
        customListTile(text: 'Delete Account', image: 'assets/delete.png'),
        SizedBox(
          height: 21.h,
        ),
        InkWell(
          onTap: () {
            SharedPrefs sf = SharedPrefs();
            sf.clearCache();
            navigationService.pushAndRemoveUntil(LogInScreen());
          },
          child: Container(
            height: 4.h,
            width: 30.w,
            decoration: BoxDecoration(
                color: Color(0xffFF3E3E),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/logout.png'),
                    color: Colors.white,
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
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
      ],
    );
  }

  Widget customListTile({String? image, String? text}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(image!),
                    height: 3.8.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    text!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 4.w,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }
}

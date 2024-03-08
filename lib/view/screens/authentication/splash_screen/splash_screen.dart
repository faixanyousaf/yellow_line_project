import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/view/screens/authentication/splash_screen/splash_signin_screen.dart';

import '../../../../helper/navigation/navigation_object.dart';
import '../../../../helper/navigation/router_path.dart';
import '../../../../helper/shared_prefs.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    get_sf_data();
    super.initState();
  }

  get_sf_data() async {
    SharedPrefs sf = SharedPrefs();
    var data = await sf.getToken();
    if (data != null) {
      var as_login = await sf.getaslogin();
      Timer(const Duration(seconds: 2), () {
        navigationService.navigatePushReplace(RouterPath.Home_Screen);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        navigationService.navigatePushReplace(RouterPath.loginRout);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h,),
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                color: Color(0xff181F30),
                image: DecorationImage(image: AssetImage('assets/background.png'),fit: BoxFit.cover),
              ),
              child: Center(
                child: Image(
                  image: AssetImage('assets/car.png'),
                  height: 30.h,
                ),
              ),
            ),
            Image(image: AssetImage('assets/dot.png'),width: 15.w,),
            SizedBox(height: 13.h,),
            Text(
              'LOREM IPSUM LOREM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 2.h,),
            Text(
              'Lorem ipsum lorem ipsum lorem ipsum\n      lorem ipsum lorem ipsum lorem',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

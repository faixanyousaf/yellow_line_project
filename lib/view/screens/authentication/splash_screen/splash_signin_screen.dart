import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/custom_button.dart';
import 'package:yellowline/view/screens/authentication/signup_screen/signup_screen.dart';


class SplashSignInScreen extends StatefulWidget {
  const SplashSignInScreen({Key? key}) : super(key: key);

  @override
  State<SplashSignInScreen> createState() => _SplashSignInScreenState();
}

class _SplashSignInScreenState extends State<SplashSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h,),
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                color: Colors.black,
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
            SizedBox(height: 12.h,),
            GestureDetector(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
              },
              child: CustomButton(
                text: 'Sign up as a User',
                borderColor: Colors.black,
                textColor: Colors.black,
                buttonColor: Color(0xffFFD542),
              ),
            ),
            SizedBox(height: 2.h,),
            CustomButton(
              text: 'Sign up as a Business',
              borderColor: Color(0xffFFD542),
              textColor: Color(0xffFFD542),
              buttonColor: Colors.black,
            ),

          ],
        ),
      ),
    );
  }
}

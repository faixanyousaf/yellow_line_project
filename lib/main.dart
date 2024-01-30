import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/view/screens/authentication/splash_screen/splash_screen.dart';
import 'package:yellowline/view/screens/home_page/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
        //HomeScreen(),
        SplashScreen(),
        debugShowCheckedModeBanner: false,
      );
    },);
  }
}


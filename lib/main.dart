import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:yellowline/view/Authentication%20Models/login/view_model/login_provider.dart';
import 'package:yellowline/view/Authentication%20Models/signup/view_model/signup_provider.dart';
import 'package:yellowline/view/screens/add_car_screen/Providers/add_vehicle_provider.dart';
import 'package:yellowline/view/screens/add_car_screen/Providers/view_list_vehicle_provider.dart';
import 'package:yellowline/view/screens/authentication/forgot_password_screen/Forget%20Provider/forget_provider.dart';
import 'package:yellowline/view/screens/authentication/forgot_password_screen/Forget%20Provider/reset_password_provider.dart';
import 'package:yellowline/view/screens/authentication/splash_screen/splash_screen.dart';
import 'helper/navigation/router.dart' as routes;
import 'helper/navigation/locator.dart';
import 'helper/navigation/navigation_service.dart';
import 'helper/navigation/locator.dart';



void main() async{
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => SingUpProvider()),
    ChangeNotifierProvider(create: (_) => ViewVehicleProvider()),
    ChangeNotifierProvider(create: (_) => AddVehicleProvider()),
    ChangeNotifierProvider(create: (_) => ForgetProvider()),
    ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: routes.generateRoute,
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


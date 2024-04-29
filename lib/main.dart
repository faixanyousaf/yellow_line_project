import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
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
import 'view/screens/My Request/view_model/view_request_provider.dart';
import 'view/screens/recovery_screens/view_model/add_request_provider.dart';
import 'view/screens/update_profile/view_model/update_user_profile_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51OuE8WAYqNfNZZ16r6VzHDbXs3VWNg98av26Ex4NP5RzuHzAXM67pWE4PZ0LWmb5U7DM2aYzZ86Yf5OwdNG1shLk00iiMKDW4y';
  // Stripe.publishableKey =
  //     'pk_live_51MRcIPJItNj1PXVqstT4avRsMRv1ZoByuSMEvCgpjkfJbROHnEb9Rtb9CPf8oGwFVGq01ERcxr3x9YxeB43Mj8jx00MkMBQgg5';
  // Stripe.publishableKey =
  //     'pk_test_51OuE8WAYqNfNZZ16r6VzHDbXs3VWNg98av26Ex4NP5RzuHzAXM67pWE4PZ0LWmb5U7DM2aYzZ86Yf5OwdNG1shLk00iiMKDW4y';
  Stripe.merchantIdentifier = 'merchant.travel.sarya.app';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => SingUpProvider()),
    ChangeNotifierProvider(create: (_) => ViewVehicleProvider()),
    ChangeNotifierProvider(create: (_) => AddVehicleProvider()),
    ChangeNotifierProvider(create: (_) => ForgetProvider()),
    ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
    ChangeNotifierProvider(create: (_) => AddRequestProvider()),
    ChangeNotifierProvider(create: (_) => ViewRequestProvider()),
    ChangeNotifierProvider(create: (_) => UpdateUserProfileProvider()),
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
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

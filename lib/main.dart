import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:yellowline/translation/translation_model.dart';
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
import 'language/language_class.dart';
import 'view/screens/My Request/view_model/view_request_provider.dart';
import 'view/screens/recovery_screens/view_model/add_request_provider.dart';
import 'view/screens/update_profile/view_model/update_user_profile_provider.dart';

final ValueNotifier<LanguageModel> language = ValueNotifier<LanguageModel>(
    LanguageModel(fromLanguage: Locale('ar'), toLanguage: Locale('en')));

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Stripe.publishableKey =
  //     'pk_live_51P8EjkP1P6rcRJTiO3uUcjh565iD5I387vGVpDPuD65Al3JLhgtv1hBXozZPydWy6SMl0nfpwLsmywcqSOkfwdDy00JTJTrkZb';
  Stripe.publishableKey =
      'pk_test_51OuE8WAYqNfNZZ16r6VzHDbXs3VWNg98av26Ex4NP5RzuHzAXM67pWE4PZ0LWmb5U7DM2aYzZ86Yf5OwdNG1shLk00iiMKDW4y';
  Stripe.merchantIdentifier = 'merchant.travel.sarya.app';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupLocator();
  HttpOverrides.global = MyHttpOverrides();
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
    final String apiKey = "AIzaSyCxVDrGwK3_-wlauORHJ1HuJkoZ5LNAdIQ";
    return ValueListenableBuilder<LanguageModel>(
      builder: (BuildContext context, LanguageModel value, Widget? child) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              navigatorKey: locator<NavigationService>().navigatorKey,
              onGenerateRoute: routes.generateRoute,
              translations: LocaleString(),
              locale: Locale('en', 'US'),
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              // theme: ThemeData(
              //   primarySwatch: Colors.blue,
              //   hoverColor: Colors.blue,
              //   indicatorColor: Colors.blue,
              //   colorScheme: ColorScheme(
              //     brightness: Brightness.light,
              //     primary: Colors.white,
              //     onPrimary: Colors.white,
              //     secondary: Colors.green,
              //     onSecondary: Colors.white,
              //     primaryContainer: Colors.greenAccent,
              //     error: Colors.black,
              //     onError: Colors.white,
              //     background: Colors.white,
              //     onBackground: Colors.white,
              //     surface: Colors.white,
              //     onSurface: Colors.white,
              //   ),
              // ),
              // darkTheme: ThemeData.dark(),

              // color:  Theme.of(context).colorScheme.secondary,

              // theme: theme.copyWith(
              //   colorScheme: theme.colorScheme.copyWith(secondary: myColor),
              // ),

              // theme: theme.copyWith(
              //   colorScheme: theme.colorScheme.copyWith(
              //     brightness: Brightness.dark,
              //         primary: Colors.red,
              //         onPrimary: Colors.white,
              //         secondary: Colors.green,
              //         onSecondary: Colors.white,
              //         primaryContainer: Colors.pink,
              //         error: Colors.black,
              //         onError: Colors.white,
              //         background: Colors.blue,
              //         onBackground: Colors.white,
              //         surface: Colors.pink,
              //         onSurface: Colors.white,
              //   ),
              // ),

              // darkTheme: ThemeData.dark(
              //   //useMaterial3: true,
              //   // colorScheme: const ColorScheme(
              //   //   brightness: Brightness.dark,
              //   //   primary: Colors.red,
              //   //   onPrimary: Colors.white,
              //   //   secondary: Colors.green,
              //   //   onSecondary: Colors.white,
              //   //   primaryContainer: Colors.pink,
              //   //   error: Colors.black,
              //   //   onError: Colors.white,
              //   //   background: Colors.blue,
              //   //   onBackground: Colors.white,
              //   //   surface: Colors.pink,
              //   //   onSurface: Colors.white,
              //   // ),
              // ),
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
      valueListenable: language,
    );
  }
}

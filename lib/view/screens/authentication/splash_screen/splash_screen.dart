import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yellowline/firebaseModel/firebase_model_view.dart';
import '../../../../core/network/routes/base_url.dart';
import '../../../../helper/navigation/navigation_object.dart';
import '../../../../helper/navigation/router_path.dart';
import '../../../../helper/shared_prefs.dart';
import '../../../../network_services/repository/authentication_repository/auth_repo.dart';
import '../../../Authentication Models/login/models/login_Responce_model.dart';
import '../../../Authentication Models/login/models/login_request.dart';

FirebaseModel? firebaseModel;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  get_firebase_Data(BuildContext? context) {
    print('the firebaseModel data is =1');
    FirebaseFirestore.instance
        .collection('appversion')
        .get()
        .then((QuerySnapshot querySnapshot) {
      print('the firebaseModel data is =${querySnapshot.docs}');
      querySnapshot.docs.forEach((doc) {
        print('the firebaseModel data is =3');
        firebaseModel =
            FirebaseModel.fromJson(doc.data() as Map<String, dynamic>);
        print('the firebaseModel data is = ${firebaseModel!.toJson()}');
        base_URL = '${firebaseModel!.baseUrl}';
        versionCheckApi(context);
      });
    });
  }

  appVersionCheck(BuildContext? context) async {
    if (firebaseModel!.androidAppOnMaintenance == false) {
      try {
        get_sf_data();
        // if (firebaseModel == null) {
        //   print('the firebaseModel data is =1');
        //   get_sf_data();
        //   // GioJson.getGio();
        //   // await oneSignalNotificationConfigration();
        //   // if (SharedPrefs().storage.hasData(SharedPrefs().visit_view_key)) {
        //   //   print(
        //   //       'visit_view_key = ${SharedPrefs().storage.read(SharedPrefs().visit_view_key)}');
        //   //   visit_view = VisitView.fromJson(
        //   //       SharedPrefs().storage.read(SharedPrefs().visit_view_key));
        //   // }
        //   FlutterNativeSplash.remove();
        //   _navigationService = locator<NavigationService>();
        //  // _handleSession();
        //  //  StaticResource().getCountries();
        //  //  StaticResource().get_resource();
        // } else {
        //   if (firebaseModel!.baseUrl!.isNotEmpty) {
        //     base_URL = '${firebaseModel!.baseUrl}';
        //     print('object of url=${base_URL}');
        //     versionCheckApi(context);
        //   }
        // }
      } on Exception catch (_) {
        if (firebaseModel!.baseUrl!.isNotEmpty) {
          base_URL = '${firebaseModel!.baseUrl}';
          print('object of url=${base_URL}');
          versionCheckApi(context);
        }
        // Navigator.of(context!).pushReplacement(MaterialPageRoute(
        //     builder: (BuildContext context) => BottomSheetCustom()));
      }
    } else {
      FlutterNativeSplash.remove();
      show_Dialog_ok(context!);
      // oneSignalNotificationConfigration().then((value) {
      //   show_Dialog_ok(context!);
      // });
    }

    // print('app check version ${appVersionCheckModel!.toJson()}');
    setState(() {});
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  String? version;
  versionCheckApi(BuildContext? context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    String v1 = Platform.isAndroid
            ? '${firebaseModel!.androidVersion}'
            : '${firebaseModel!.iosVersion}',
        v2 = '${version}';
    print(
        'versions = ${firebaseModel!.androidVersion} and ${firebaseModel!.iosVersion}');
    int v1Number = getExtendedVersionNumber(v1);
    int v2Number = getExtendedVersionNumber(v2);
    if (v1Number > v2Number && v1Number != v2Number) {
      print('1');
      if (Platform.isAndroid
          ? firebaseModel!.androidMatchVersion == false
          : firebaseModel!.iosMatchVersion == false) {
        //InternetConnectivity().check_connection_stream();
        print('2');
        FlutterNativeSplash.remove();
        show_Dialog(context!);
        print('3');
        // oneSignalNotificationConfigration().then((value) {
        //   show_Dialog(context!);
        // });
        // Navigator.of(context).pop();
      } else {
        print('4');
        //InternetConnectivity().check_connection_stream();
        FlutterNativeSplash.remove();
        show_Dialog_Splash(context!);
        // oneSignalNotificationConfigration().then((value) {
        //   show_Dialog_Splash(context!);
        // });

        //Navigator.of(context!).pop();
      }
    } else {
      print('call second object');
      get_sf_data();
      // GioJson.getGio();
      // await oneSignalNotificationConfigration();
      // if (SharedPrefs().storage.hasData(SharedPrefs().visit_view_key)) {
      //   print(
      //       'visit_view_key = ${SharedPrefs().storage.read(SharedPrefs().visit_view_key)}');
      //   visit_view = VisitView.fromJson(
      //       SharedPrefs().storage.read(SharedPrefs().visit_view_key));
      // }
      FlutterNativeSplash.remove();
      //_navigationService = locator<NavigationService>();
      // _handleSession();
      // StaticResource().getCountries();
      // StaticResource().get_resource();
    }
  }

  show_Dialog(BuildContext context) async {
    print('call dialog');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(
                    "Update required",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
              content: new Text(
                  "We have rolled our some enhancements for a better experience. Please update to the latest version to continue.",
                  style: TextStyle(color: Colors.black)),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("UPDATE", style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      String? url = '${firebaseModel!.androidAppUrl}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    } else if (Platform.isIOS) {
                      String? url = '${firebaseModel!.iosAppUrl}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    }
                  },
                ),
                CupertinoDialogAction(
                  child: Text("LATER", style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    get_sf_data();
                    // GioJson.getGio();
                    // await oneSignalNotificationConfigration();
                    // if (SharedPrefs()
                    //     .storage
                    //     .hasData(SharedPrefs().visit_view_key)) {
                    //   print(
                    //       'visit_view_key = ${SharedPrefs().storage.read(SharedPrefs().visit_view_key)}');
                    //   visit_view = VisitView.fromJson(SharedPrefs()
                    //       .storage
                    //       .read(SharedPrefs().visit_view_key));
                    // }
                    FlutterNativeSplash.remove();
                    //_navigationService = locator<NavigationService>();
                    // _handleSession();
                    // StaticResource().getCountries();
                    // StaticResource().get_resource();

                    //Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  show_Dialog_Splash(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(
                    "Update required",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
              content: new Text(
                  "We have rolled our some enhancements for a better experience. Please update to the latest version to continue.",
                  style: TextStyle(color: Colors.black)),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("UPDATE", style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      String? url = '${firebaseModel!.androidAppUrl}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    } else if (Platform.isIOS) {
                      String? url = '${firebaseModel!.iosAppUrl}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  show_Dialog_ok(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light(),
            child: CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(
                    "App is on maintenance",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
              content: new Text(
                  "Sarya app is on maintenance, We will be back soon.",
                  style: TextStyle(color: Colors.black)),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Ok", style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    get_firebase_Data(context);
    // get_sf_data();
    super.initState();
  }

  get_sf_data() async {
    SharedPrefs sf = SharedPrefs();
    var data = await sf.getToken();
    if (data != null) {
      var as_login = await sf.getaslogin();
      var password = await sf.get_password();
      var data = await sf.getUser();
      if (as_login == '1') {
        LoginResponceModel loginResponceModel =
            LoginResponceModel.fromJson(data);
        Sign_In_Request request = Sign_In_Request(
            password: password,
            email: loginResponceModel.user!.email,
            account_type: '2');
        var result =
            await AuthRepository.instance.signIn(body: request.toJson());
        LoginResponceModel responceModel = result;
        print('${responceModel.toJson()}');
        sf.saveUser(responceModel.toJson());
        sf.saveToken(responceModel.accessToken);
        sf.saveaslogin('1');
        sf.saveid(responceModel.user!.id.toString());
        Timer(const Duration(seconds: 1), () {
          navigationService.navigatePushReplace(RouterPath.Home_Screen);
        });
      } else {
        LoginResponceModel loginResponceModel =
            LoginResponceModel.fromJson(data);
        Map<String, dynamic> map = {
          'first_name': '${loginResponceModel.user!.firstName}',
          'last_name': '${loginResponceModel.user!.lastName}',
          'email': '${loginResponceModel.user!.email}',
        };
        var result = await AuthRepository.instance.social_signUp(body: map);
        print('result....$result');
        LoginResponceModel responceModel = LoginResponceModel.fromJson(result);
        print('${responceModel.toJson()}');
        SharedPrefs sf = SharedPrefs();
        sf.saveUser(responceModel.toJson());
        sf.saveToken(responceModel.accessToken);
        sf.saveaslogin('2');
        sf.saveid(responceModel.user!.id.toString());
        navigationService.navigatePushReplace(RouterPath.Home_Screen);
      }
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
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                color: Color(0xff181F30),
                image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: Image(
                  image: AssetImage('assets/car.png'),
                  height: 30.h,
                ),
              ),
            ),
            Image(
              image: AssetImage('assets/dot.png'),
              width: 15.w,
            ),
            SizedBox(
              height: 13.h,
            ),
            // Text(
            //   'LOREM IPSUM LOREM',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 15.sp,
            //   ),
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),
            // Text(
            //   'Lorem ipsum lorem ipsum lorem ipsum\n      lorem ipsum lorem ipsum lorem',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 10.sp,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

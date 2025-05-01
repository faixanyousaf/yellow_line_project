import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/helper/navigation/navigation_object.dart';
import 'package:yellowline/helper/navigation/router_path.dart';
import 'package:yellowline/view/screens/home_page/drawer_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../helper/shared_prefs.dart';
import '../../../network_services/repository/authentication_repository/auth_repo.dart';
import '../../../network_services/repository/user_repository/user_repo.dart';
import '../../Authentication Models/login/models/login_Responce_model.dart';
import '../../Authentication Models/sos/sos_screen.dart';
import '../recovery_screens/model/my_pending_request_model.dart';
import '../recovery_screens/view/my_pending_request_screen.dart';
import '../recovery_screens/view_model/add_request_provider.dart';

bool stop_pending_request_routing = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int activePage = 0;
  List<String> service_list = [
    'Vehicle Recovery'.tr,
    'Vehicle Movers'.tr,
    'Rental Equipments'.tr
  ];
  final List<Widget> pages = [
    Container(
        height: 28.h,
        child: Center(
          child: Image(
            image: AssetImage('assets/car.png'),
            height: 28.h,
          ),
        )),
    Container(
        height: 28.h,
        child: Center(
          child: Image(
            image: AssetImage('assets/car.png'),
            height: 28.h,
          ),
        )),
    Container(
        child: Center(
      child: Image(
        image: AssetImage('assets/car.png'),
        height: 28.h,
      ),
    )),
  ];
  Timer? timer;
  @override
  void initState() {
    get_user_data();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      call_pending_request();
    });
    // _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
    //   print('update_location');
    //   SharedPrefs sf = SharedPrefs();
    //   var id = await sf.getid();
    //   Position position = await requestLocation();
    //   UserRepository.instance.update_location(body: {
    //     "lat": position.latitude,
    //     "lng": position.longitude,
    //     "user_id": id
    //   });
    // });
    super.initState();
  }

  call_pending_request() async {
    SharedPrefs sf = SharedPrefs();
    var id = await sf.getid();
    //final player = AudioPlayer();
    //await player.setAsset('assets/audio/Alert_Sound.mp3');
    List result = await AuthRepository.instance.my_pending_requests(id: id);
    if (result.isNotEmpty && stop_pending_request_routing == false) {
      // await player.play();
      PendingRequestModel model = PendingRequestModel.fromJson(result[0]);
      Navigator.of(navigationService.navigatorKey.currentState!.context)
          .push(MaterialPageRoute(
              builder: (c) => MyPendingRequestMapView(
                    driverRequestModel: model,
                    dropoff_latLng: LatLng(double.parse(model.dropLat),
                        double.parse(model.dropLong)),
                    pickup_latLng: LatLng(double.parse(model.driverLat),
                        double.parse(model.dropLong)),
                    cancel_request: () {
                      AuthRepository.instance.cancel_ride(body: {
                        'request_id': model.id,
                        'driver_id': '${id}',
                      });
                    },
                  )));
    }
    if (result.isEmpty && stop_pending_request_routing == true) {
      Navigator.of(navigationService.navigatorKey.currentState!.context).pop();
    }
  }

  Timer? _timer;
  @override
  void dispose() {
    timer!.cancel();
    _timer!.cancel();
    super.dispose();
  }

  Future<Position> requestLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    return position;
  }

  LoginResponceModel? loginResponceModel;
  get_user_data() async {
    SharedPrefs sf = SharedPrefs();
    var user = await sf.getUser();
    loginResponceModel = LoginResponceModel.fromJson(user);
    setState(() {});
  }

  List list_icon = [
    'assets/truck_recovery.png',
    'assets/truck_movers.png',
    'assets/truck_equipment.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xff181F30),
        child: DrawerScreen(),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 9.h),
              child: Image(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Image(image: AssetImage('assets/menu.png'))),
                      if (loginResponceModel != null)
                        InkWell(
                          onTap: () {
                            navigationService
                                .navigateTo(RouterPath.UpdateUserProfileScreen)!
                                .then((value) {
                              get_user_data();
                            });
                          },
                          child: loginResponceModel!.user!.profilePicture ==
                                  null
                              ? CircleAvatar(
                                  radius: 2.0.h,
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 2.0.h,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      '${loginResponceModel!.user!.profilePicture}')),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (loginResponceModel != null)
                        Text(
                          'Welcome, ${loginResponceModel!.user!.firstName} ${loginResponceModel!.user!.lastName}'
                              .tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (c) => SosScreen()));
                        },
                        child: Container(
                          height: 4.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: Color(0xffFC7C56),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'SOS',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  //SizedBox(height: 2.h,),
                  Container(
                    height: 40.h,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (value) {
                            setState(() {
                              activePage = value;
                            });
                          },
                          itemCount: pages.length,
                          itemBuilder: (context, index) {
                            return pages[index % pages.length];
                          },
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: 5.h,
                          child: Center(
                            child: SmoothPageIndicator(
                              count: pages.length,
                              controller: _pageController,
                              effect: ExpandingDotsEffect(
                                  dotColor: Colors.white,
                                  dotHeight: 1.h,
                                  dotWidth: 2.w,
                                  activeDotColor: Colors.white,
                                  //strokeWidth: 5.w,
                                  expansionFactor: 1.1.w),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'Recover your Vehicle'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        height: 20.h,
                        width: 100.w,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              navigationService.navigateTo(
                                  RouterPath.add_request_screen_one);
                            },
                            child: Container(
                              height: 20.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff181F30),
                                //Colors.black
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                      width: 35.w,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/truck_4x.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Vehicle Recovery',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          'Request a recovery now or',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.sp,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          'schedule for later!',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.sp,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // child: ListView.builder(
                        //   scrollDirection: Axis.horizontal,
                        //   itemCount: service_list.length,
                        //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                        //   itemBuilder: (context, index) {
                        //     return InkWell(
                        //       onTap: () {
                        //         navigationService.navigateTo(
                        //             RouterPath.add_request_screen_one);
                        //       },
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             height: 19.h,
                        //             width: 28.w,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(10),
                        //               color: Color(0xff181F30),
                        //               //Colors.black
                        //             ),
                        //             child: Padding(
                        //               padding:
                        //                   EdgeInsets.symmetric(horizontal: 3.w),
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   SizedBox(
                        //                     height: 2.h,
                        //                   ),
                        //                   Container(
                        //                     height: 6.h,
                        //                     width: 12.w,
                        //                     decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius:
                        //                           BorderRadius.circular(10),
                        //                     ),
                        //                     child: Center(
                        //                       child: Image(
                        //                         image: AssetImage(
                        //                             '${list_icon[index]}'),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 3.h,
                        //                   ),
                        //                   Text(
                        //                     '${service_list[index]}'.tr,
                        //                     maxLines: 3,
                        //                     overflow: TextOverflow.ellipsis,
                        //                     style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 11.sp,
                        //                       overflow: TextOverflow.ellipsis,
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 2.5.w,
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => TrackingHomeScreen(),
                      //         ));
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 5.w),
                      //     child: Container(
                      //       height: 7.h,
                      //       decoration: BoxDecoration(
                      //           color: Color(0xffFFD542),
                      //           borderRadius: BorderRadius.circular(20)),
                      //       child: Center(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Image(
                      //               image: AssetImage('assets/cars.png'),
                      //               width: 8.w,
                      //             ),
                      //             SizedBox(
                      //               width: 7.w,
                      //             ),
                      //             Text(
                      //               'Add a Car',
                      //               style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 12.sp,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 3.h,
                      // ),
                    ],
                  ),
                ))
          ],
        ),
      ),
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

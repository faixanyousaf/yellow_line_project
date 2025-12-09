import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/bottom_button.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import 'package:yellowline/global_widgets/asset_to_unit8list.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:yellowline/view/screens/recovery_screens/view/choose_location.dart';

import '../../../../global_widgets/custom_drop_conatiner.dart';
import '../../../../helper/navigation/navigation_object.dart';
import '../../../../helper/navigation/router_path.dart';
import '../../../../helper/shared_prefs.dart';
import '../../../../network_services/repository/authentication_repository/auth_repo.dart';
import '../../../Authentication Models/login/models/login_Responce_model.dart';
import '../../home_page/drawer_screen.dart';
import '../../home_page/home_screen.dart';
import '../model/my_pending_request_model.dart';
import '../model/request_recovery_model.dart';
import '../view_model/add_request_provider.dart';
import 'my_pending_request_screen.dart';
import 'nearbby_search.dart';

class DropOffScreen extends StatefulWidget {
  const DropOffScreen({Key? key}) : super(key: key);

  @override
  State<DropOffScreen> createState() => _DropOffScreenState();
}

class _DropOffScreenState extends State<DropOffScreen> {
  List list_of_suggestion = [
    'Garage'.tr,
    'Service Station'.tr,
    'Petrol Pump'.tr
  ];
  TextEditingController controller_pickup = TextEditingController();
  TextEditingController controller_drop_off = TextEditingController();
  GoogleMapController? _controller;
  LatLng? pickup_latLng;
  LatLng? dropoff_latLng;
  int selected_destination = 1;
  void onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    _gotoPosition();
  }

  void _gotoPosition({bool? move_camera = true}) async {
    final position = await requestLocation();
    Future.delayed(Duration(seconds: 1), () async {
      await _controller!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      )));
    });
    getLocationAddress(
        latLng: LatLng(position.latitude, position.longitude), add_name: true);
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

  PlacesAutocompleteResponse? placesAutocompleteResponse;
  var kGoogleApiKey = 'AIzaSyAoknLjF2XNcjPDW25O5QOQFLgdVKc6GgU';
  Future getNearbyPlaces(String keyword) async {
    late GoogleMapsPlaces places;
    if (Platform.isAndroid) {
      places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
      );
    } else {
      places = GoogleMapsPlaces(
          apiKey: kGoogleApiKey,
          apiHeaders: await const GoogleApiHeaders().getHeaders());
    }
    placesAutocompleteResponse = await places.autocomplete('$keyword');
    setState(() {});
  }

  String search_text = '';
  bool show_search_result = false;

  get_place_by_id({required String place_id, required String name}) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());
    PlacesDetailsResponse place_detail =
        await places.getDetailsByPlaceId(place_id);
    getLocationAddress(
        latLng: LatLng(place_detail.result.geometry!.location.lat,
            place_detail.result.geometry!.location.lng),
        add_name: false,
        selected_name: name);
  }

  LatLngBounds _bounds(Map<MarkerId, Marker> markers) {
    final positions = markers.entries
        .map(
          (marker) => LatLng(
              marker.value.position.latitude, marker.value.position.longitude),
        )
        .toList();
    return _createBounds(positions);
  }

  add_poly_line() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyAoknLjF2XNcjPDW25O5QOQFLgdVKc6GgU',
        PointLatLng(pickup_latLng!.latitude, pickup_latLng!.longitude),
        PointLatLng(dropoff_latLng!.latitude, dropoff_latLng!.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId("mdlDm");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Color(0xffFFCC1B),
        points: polylineCoordinates,
        patterns: [
          PatternItem.dash(8),
          PatternItem.gap(15),
        ],
        width: 4);
    polylines[id] = polyline;
    setState(() {});
    final AddRequestProvider provider =
        Provider.of<AddRequestProvider>(context, listen: false);
    provider.caculate_fare(data: {
      "pick_up_lat": pickup_latLng!.latitude.toString(),
      "pick_up_long": pickup_latLng!.longitude.toString(),
      "drop_off_lat": dropoff_latLng!.latitude.toString(),
      "drop_off_long": dropoff_latLng!.longitude.toString(),
      "recoveryType": recovery_type,
    });
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }

  Map<PolylineId, Polyline> polylines = {};
  int index = 1;

  @override
  void deactivate() {
    final AddRequestProvider provider =
        Provider.of<AddRequestProvider>(context, listen: false);
    provider.clear_info();
    super.deactivate();
  }

  String map_style = '';
  Future getMapStyle() async {
    map_style = await rootBundle.loadString('assets/map_style/dark_map.json');
    print('loaded map style');
    setState(() {});
  }

  bool? isDaytime;

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
                    pickup_latLng: LatLng(double.parse(model.pickUpLat),
                        double.parse(model.pickUpLong)),
                    cancel_request: (String reason) {
                      AuthRepository.instance.cancel_ride(body: {
                        'request_id': model.id,
                        'user_id': '${id}',
                        'reason': '${reason}'
                      });
                    },
                  )));
    }
    if (result.isEmpty && stop_pending_request_routing == true) {
      //Navigator.of(navigationService.navigatorKey.currentState!.context).pop();
      // final AddRequestProvider provider =
      //     Provider.of<AddRequestProvider>(context);
      // provider.clear_info();
      navigationService.pushAndRemoveUntil(DropOffScreen());
    }
    if (show_rating == false) {
      AuthRepository.instance.check_review(id: id).then((v) {
        if (v['data'] != null) {
          print('in submit');
          tripId = v['data']['tripId'];
          show_rating = true;
          // showRatingDialog(
          //     context: context,
          //     rating_info: (v) {
          //       AuthRepository.instance.submit_review(body: {
          //         "user_id": int.parse("${id}"),
          //         "tripId": tripId,
          //         "rating": v['rating'],
          //         "comment": v['comment'],
          //         "reviewType": "user_to_rider"
          //       });
          //     });
          rate_dialog(
              context: context,
              rating_info: (v) {
                AuthRepository.instance.submit_review(body: {
                  "user_id": int.parse("${id}"),
                  "tripId": tripId,
                  "rating": v['rating'],
                  "comment": v['comment'],
                  "reviewType": "user_to_rider"
                });
              });
        }
        print('check_review...${v}');
      });
    }
  }

  var tripId;
  bool show_rating = false;
  Timer? timer;
  @override
  void initState() {
    final now = DateTime.now();
    final hour = now.hour;
    if (hour >= 6 && hour < 18) {
      isDaytime = true;
      print('It is daytime.');
    } else {
      isDaytime = false;
      print('It is nighttime.');
    }
    getMapStyle();
    final AddRequestProvider provider =
        Provider.of<AddRequestProvider>(context, listen: false);
    //provider.get_recovery_type();
    provider.initialize_socket(context);
    super.initState();
    get_user_data();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      call_pending_request();
    });
  }

  LoginResponceModel? loginResponceModel;
  get_user_data() async {
    SharedPrefs sf = SharedPrefs();
    var user = await sf.getUser();
    loginResponceModel = LoginResponceModel.fromJson(user);
    setState(() {});
  }

  double _currentZoom = 15.5;
  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      _controller!.animateCamera(
        CameraUpdate.zoomTo(_currentZoom),
      );
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      _controller!.animateCamera(
        CameraUpdate.zoomTo(_currentZoom),
      );
    });
  }

  int recovery_type = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final AddRequestProvider provider =
        Provider.of<AddRequestProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xff181F30),
        child: DrawerScreen(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: DataLoading(
          isLoading: provider.loading,
          child: Container(
            height: 100.h,
            width: 100.w,
            child: Stack(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 100.h,
                          width: 100.w,
                          child: map_style.isEmpty && isDaytime != null
                              ? SizedBox()
                              : GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(19.0760, 72.8777),
                                    zoom: 22,
                                  ),
                                  style: isDaytime == true ? null : map_style,
                                  polylines: Set<Polyline>.of(polylines.values),
                                  onMapCreated: (controller) {
                                    onMapCreated(controller);
                                  },
                                  myLocationButtonEnabled: false,
                                  zoomControlsEnabled: true,
                                  zoomGesturesEnabled: true,
                                  myLocationEnabled: true,
                                  markers: Set<Marker>.of(
                                      provider.markersList.values),
                                  // onTap: (v) {
                                  //   print('Clicked');
                                  //   getLocationAddress(
                                  //       latLng: v, add_name: true);
                                  // },
                                ),
                        ),
                        // Container(
                        //     height: 31.h,
                        //     width: 100.w,
                        //     child: Transform.translate(
                        //       offset: Offset(0, -2.h),
                        //       child: provider.responce_fare_model == null
                        //           ? Container(
                        //               decoration: BoxDecoration(
                        //                   color: Color(0xff181F30),
                        //                   borderRadius: BorderRadius.only(
                        //                       topLeft: Radius.circular(20),
                        //                       topRight: Radius.circular(20))),
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   SizedBox(
                        //                     height: 2.h,
                        //                   ),
                        //                   Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         horizontal: 5.w),
                        //                     child: Text(
                        //                       'Drop-off Suggestions:'.tr,
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: 10.sp),
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 1.h,
                        //                   ),
                        //                   Container(
                        //                     height: 7.h,
                        //                     child: ListView.builder(
                        //                       itemCount:
                        //                           list_of_suggestion.length,
                        //                       scrollDirection: Axis.horizontal,
                        //                       padding: EdgeInsets.symmetric(
                        //                           horizontal: 5.w),
                        //                       itemBuilder: (context, index) =>
                        //                           InkWell(
                        //                         onTap: () async {
                        //                           Position position =
                        //                               await requestLocation();
                        //                           Navigator.push(
                        //                               context,
                        //                               MaterialPageRoute(
                        //                                   builder: (c) =>
                        //                                       GoogleNearbySearch(
                        //                                         latLng: LatLng(
                        //                                             position
                        //                                                 .latitude,
                        //                                             position
                        //                                                 .longitude),
                        //                                         name:
                        //                                             '${list_of_suggestion[index]}',
                        //                                       ))).then((value) {
                        //                             if (value != null) {
                        //                               selected_destination =
                        //                                   value['as'];
                        //                               getLocationAddress(
                        //                                   add_name: false,
                        //                                   selected_name:
                        //                                       value['name'],
                        //                                   latLng:
                        //                                       value['latlng']);
                        //                             }
                        //                           });
                        //                         },
                        //                         child: Row(
                        //                           children: [
                        //                             dropContainer(
                        //                                 image:
                        //                                     'assets/garage.png',
                        //                                 text:
                        //                                     '${list_of_suggestion[index]}'),
                        //                             SizedBox(
                        //                               width: 2.w,
                        //                             )
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 1.h,
                        //                   ),
                        //                   Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         horizontal: 5.w),
                        //                     child: Text(
                        //                       'Recovery Type'.tr,
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: 10.sp),
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 1.h,
                        //                   ),
                        //                   Container(
                        //                     height: 3.5.h,
                        //                     child: ListView.builder(
                        //                       scrollDirection: Axis.horizontal,
                        //                       itemCount: provider
                        //                           .recovery_type_model.length,
                        //                       padding: EdgeInsets.symmetric(
                        //                           horizontal: 5.w),
                        //                       itemBuilder: (context, index) =>
                        //                           InkWell(
                        //                         onTap: () {
                        //                           provider.selected_recovery_type =
                        //                               '${provider.recovery_type_model[index].typeName}';
                        //                           setState(() {});
                        //                         },
                        //                         child: Row(
                        //                           children: [
                        //                             Container(
                        //                               height: 2.8.h,
                        //                               decoration: BoxDecoration(
                        //                                   borderRadius:
                        //                                       BorderRadius
                        //                                           .circular(30),
                        //                                   border: Border.all(
                        //                                       width: 0.7,
                        //                                       color: provider
                        //                                                   .selected_recovery_type ==
                        //                                               '${provider.recovery_type_model[index].typeName}'
                        //                                           ? Color(
                        //                                               0xffFFCC1B)
                        //                                           : Colors
                        //                                               .white)),
                        //                               child: Center(
                        //                                 child: Padding(
                        //                                   padding:
                        //                                       const EdgeInsets
                        //                                           .symmetric(
                        //                                           horizontal:
                        //                                               18.0),
                        //                                   child: Text(
                        //                                     '${provider.recovery_type_model[index].typeName}',
                        //                                     style: TextStyle(
                        //                                         color: provider
                        //                                                     .selected_recovery_type ==
                        //                                                 '${provider.recovery_type_model[index].typeName}'
                        //                                             ? Color(
                        //                                                 0xffFFCC1B)
                        //                                             : Colors
                        //                                                 .white,
                        //                                         fontSize: 8.sp),
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               width: 2.3.w,
                        //                             )
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 2.h,
                        //                   ),
                        //                   Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         horizontal: 5.w),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         Expanded(
                        //                           child: InkWell(
                        //                             onTap: () {
                        //                               if (pickup_latLng !=
                        //                                       null &&
                        //                                   dropoff_latLng !=
                        //                                       null) {
                        //                                 int index_recovery = provider
                        //                                     .recovery_type_model
                        //                                     .indexWhere((element) =>
                        //                                         element
                        //                                             .typeName ==
                        //                                         provider
                        //                                             .selected_recovery_type);
                        //                                 provider.request_model = Request_Recovery_Model(
                        //                                     lat1: pickup_latLng!
                        //                                         .latitude
                        //                                         .toString(),
                        //                                     long1: pickup_latLng!
                        //                                         .longitude
                        //                                         .toString(),
                        //                                     lat2:
                        //                                         dropoff_latLng!
                        //                                             .latitude
                        //                                             .toString(),
                        //                                     long2:
                        //                                         dropoff_latLng!
                        //                                             .longitude
                        //                                             .toString(),
                        //                                     plateNumber: 858,
                        //                                     recoveryType: provider
                        //                                         .recovery_type_model[
                        //                                             index_recovery]
                        //                                         .id);
                        //                                 provider
                        //                                     .calculate_fare();
                        //                               }
                        //                             },
                        //                             child: CustomBottomButton(
                        //                               text: 'Continue'.tr,
                        //                               buttonColor:
                        //                                   Color(0xffFFCC1B),
                        //                               textColor: Colors.black,
                        //                               borderColor: Colors.black,
                        //                             ),
                        //                           ),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 2.h,
                        //                   ),
                        //                 ],
                        //               ),
                        //             )
                        //           : Container(
                        //               width: 100.w,
                        //               decoration: BoxDecoration(
                        //                   color: Color(0xff181F30),
                        //                   borderRadius: BorderRadius.only(
                        //                       topLeft: Radius.circular(20),
                        //                       topRight: Radius.circular(20))),
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   SizedBox(
                        //                     height: 2.h,
                        //                   ),
                        //                   Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         horizontal: 5.w),
                        //                     child: Text(
                        //                       'Booking Details:'.tr,
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: 10.sp),
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 1.h,
                        //                   ),
                        //                   Container(
                        //                     child: Row(
                        //                       children: [
                        //                         SizedBox(
                        //                           width: 5.w,
                        //                         ),
                        //                         CustomDropContainer(
                        //                           height: 7.h,
                        //                           width: 28.w,
                        //                           text: 'Time',
                        //                           texxt: '35 mins',
                        //                         ),
                        //                         SizedBox(
                        //                           width: 2.w,
                        //                         ),
                        //                         CustomDropContainer(
                        //                           height: 7.h,
                        //                           width: 28.w,
                        //                           text: 'Distance'.tr,
                        //                           texxt:
                        //                               '${provider.responce_fare_model!.distance} km',
                        //                         ),
                        //                         SizedBox(
                        //                           width: 2.w,
                        //                         ),
                        //                         CustomDropContainer(
                        //                           height: 7.h,
                        //                           width: 28.w,
                        //                           text: 'Price'.tr,
                        //                           texxt:
                        //                               '${provider.responce_fare_model!.totalCharges}',
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   // SizedBox(
                        //                   //   height: 2.h,
                        //                   // ),
                        //                   // Padding(
                        //                   //   padding: EdgeInsets.symmetric(
                        //                   //       horizontal: 5.w),
                        //                   //   child: Row(
                        //                   //     crossAxisAlignment:
                        //                   //         CrossAxisAlignment.start,
                        //                   //     children: [
                        //                   //       Padding(
                        //                   //         padding: EdgeInsets.symmetric(
                        //                   //             vertical: 0.5.h),
                        //                   //         child: Text(
                        //                   //           'Payment Method',
                        //                   //           style: TextStyle(
                        //                   //               color: Colors.white,
                        //                   //               fontSize: 10.sp),
                        //                   //         ),
                        //                   //       ),
                        //                   //       SizedBox(
                        //                   //         width: 3.w,
                        //                   //       ),
                        //                   //       Container(
                        //                   //         // height: 4.h,
                        //                   //         width: 45.w,
                        //                   //         padding: EdgeInsets.all(2),
                        //                   //         decoration: BoxDecoration(
                        //                   //             border: Border.all(
                        //                   //                 width: 0.5,
                        //                   //                 color: Colors.white),
                        //                   //             borderRadius:
                        //                   //                 BorderRadius.circular(
                        //                   //                     7),
                        //                   //             color: Colors.white),
                        //                   //         child: Row(
                        //                   //           children: [
                        //                   //             Expanded(
                        //                   //               child: GestureDetector(
                        //                   //                 onTap: () {
                        //                   //                   index = 1;
                        //                   //                   setState(() {});
                        //                   //                 },
                        //                   //                 child: Container(
                        //                   //                   height: 3.2.h,
                        //                   //                   //width: 22.w,
                        //                   //                   decoration: BoxDecoration(
                        //                   //                       border: Border.all(
                        //                   //                           width: 0.5,
                        //                   //                           color: Colors
                        //                   //                               .white),
                        //                   //                       borderRadius:
                        //                   //                           BorderRadius
                        //                   //                               .circular(
                        //                   //                                   7),
                        //                   //                       color: index ==
                        //                   //                               1
                        //                   //                           ? Color(
                        //                   //                               0xffFFD542)
                        //                   //                           : Colors
                        //                   //                               .white),
                        //                   //                   child: Center(
                        //                   //                     child: Text(
                        //                   //                       'Cash',
                        //                   //                       style: TextStyle(
                        //                   //                           color: Colors
                        //                   //                               .black,
                        //                   //                           fontSize:
                        //                   //                               9.sp),
                        //                   //                     ),
                        //                   //                   ),
                        //                   //                 ),
                        //                   //               ),
                        //                   //             ),
                        //                   //             Expanded(
                        //                   //               child: GestureDetector(
                        //                   //                 onTap: () {
                        //                   //                   index = 2;
                        //                   //                   setState(() {});
                        //                   //                 },
                        //                   //                 child: Container(
                        //                   //                   height: 3.2.h,
                        //                   //                   //width: 22.2.w,
                        //                   //                   decoration: BoxDecoration(
                        //                   //                       border: Border.all(
                        //                   //                           width: 0.5,
                        //                   //                           color: Colors
                        //                   //                               .white),
                        //                   //                       borderRadius:
                        //                   //                           BorderRadius
                        //                   //                               .circular(
                        //                   //                                   7),
                        //                   //                       color: index ==
                        //                   //                               2
                        //                   //                           ? Color(
                        //                   //                               0xffFFD542)
                        //                   //                           : Colors
                        //                   //                               .white),
                        //                   //                   child: Center(
                        //                   //                     child: Text(
                        //                   //                       'Card',
                        //                   //                       style: TextStyle(
                        //                   //                           color: Colors
                        //                   //                               .black,
                        //                   //                           fontSize:
                        //                   //                               9.sp),
                        //                   //                     ),
                        //                   //                   ),
                        //                   //                 ),
                        //                   //               ),
                        //                   //             )
                        //                   //           ],
                        //                   //         ),
                        //                   //       ),
                        //                   //     ],
                        //                   //   ),
                        //                   // ),
                        //                   SizedBox(
                        //                     height: 7.h,
                        //                   ),
                        //                   Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         horizontal: 5.w),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         Expanded(
                        //                           child: InkWell(
                        //                             onTap: () {
                        //                               provider
                        //                                   .charge_user(context);
                        //                             },
                        //                             child: CustomBottomButton(
                        //                               text: 'Confirm'.tr,
                        //                               buttonColor:
                        //                                   Color(0xffFFCC1B),
                        //                               textColor:
                        //                                   Color(0xff181F30),
                        //                               borderColor:
                        //                                   Color(0xffFFCC1B),
                        //                             ),
                        //                           ),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   SizedBox(
                        //                     height: 2.h,
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //     ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 22.h,
                    right: 3.w,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            _zoomIn();
                          },
                          child: Container(
                            height: 6.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle),
                            child: Center(
                                child: Icon(Icons.zoom_in,
                                    size: 35, color: Colors.grey)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        InkWell(
                          onTap: () async {
                            _zoomOut();
                          },
                          child: Container(
                            height: 6.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle),
                            child: Center(
                                child: Icon(Icons.zoom_out_sharp,
                                    size: 35, color: Colors.grey)),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    top: 35.h,
                    right: 3.w,
                    child: InkWell(
                      onTap: () async {
                        final position = await requestLocation();
                        await _controller!.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(position.latitude, position.longitude),
                          zoom: 15.5,
                        )));
                      },
                      child: Container(
                        height: 6.h,
                        width: 12.w,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: Center(
                            child: Icon(Icons.my_location_sharp,
                                size: 25, color: Colors.grey)),
                      ),
                    )),
                // provider.totalFareModel != null
                //     ? Positioned(
                //         bottom: 0.h,
                //         child: Container(
                //           width: 100.w,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               Container(
                //                 padding: EdgeInsets.symmetric(horizontal: 5.w),
                //                 width: 100.w,
                //                 decoration: BoxDecoration(
                //                     color: Colors.black,
                //                     borderRadius: BorderRadius.only(
                //                         topLeft: Radius.circular(30),
                //                         topRight: Radius.circular(30))),
                //                 child: Column(
                //                   children: [
                //                     SizedBox(
                //                       height: 2.h,
                //                     ),
                //                     Container(
                //                       width: 20.w,
                //                       height: 1.h,
                //                       decoration: BoxDecoration(
                //                           color: Colors.grey,
                //                           borderRadius:
                //                               BorderRadius.circular(30)),
                //                     ),
                //                     SizedBox(
                //                       height: 2.h,
                //                     ),
                //                     Text(
                //                       'Your Fare',
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 16,
                //                           color: Colors.grey),
                //                     ),
                //                     Text(
                //                       'AED ${provider.totalFareModel?.data?.totalCharges}',
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 30,
                //                           color: Colors.white),
                //                     ),
                //                     Text(
                //                       'Travel Time : ${provider.totalFareModel?.data?.time}',
                //                       style: TextStyle(
                //                           fontSize: 13, color: Colors.white),
                //                     ),
                //                     if (!provider.load_find_driver)
                //                       SizedBox(
                //                         height: 2.h,
                //                       ),
                //                     if (!provider.load_find_driver)
                //                       InkWell(
                //                         onTap: () {
                //                           if (pickup_latLng != null &&
                //                               dropoff_latLng != null) {
                //                             provider.find_driver_request(data: {
                //                               "amount": provider.totalFareModel
                //                                   ?.data?.totalCharges
                //                                   .toString(),
                //                               "pick_up_lat": pickup_latLng!
                //                                   .latitude
                //                                   .toString(),
                //                               "pick_up_long": pickup_latLng!
                //                                   .longitude
                //                                   .toString(),
                //                               "drop_lat": dropoff_latLng!
                //                                   .latitude
                //                                   .toString(),
                //                               "drop_long": dropoff_latLng!
                //                                   .longitude
                //                                   .toString(),
                //                               "pickup_name":
                //                                   "${controller_pickup.text}",
                //                               "drop_name":
                //                                   "${controller_drop_off.text}",
                //                               "recovery_type": 2,
                //                               'time': provider.totalFareModel
                //                                       ?.data?.time ??
                //                                   '0',
                //                               'distance': provider
                //                                       .totalFareModel
                //                                       ?.data
                //                                       ?.distance ??
                //                                   '0'
                //                             });
                //                             // int index_recovery = provider.recovery_type_model
                //                             //     .indexWhere((element) =>
                //                             //         element.typeName ==
                //                             //         provider.selected_recovery_type);
                //                             // provider.request_model = Request_Recovery_Model(
                //                             //     lat1: pickup_latLng!.latitude.toString(),
                //                             //     long1: pickup_latLng!.longitude.toString(),
                //                             //     lat2: dropoff_latLng!.latitude.toString(),
                //                             //     long2: dropoff_latLng!.longitude.toString(),
                //                             //     plateNumber: 858,
                //                             //     recoveryType: provider
                //                             //         .recovery_type_model[index_recovery].id);
                //                             // provider.calculate_fare();
                //                           } else {
                //                             var snackBar = SnackBar(
                //                               content: Text(
                //                                   'Please select pickup and drop of location first'),
                //                               duration: Duration(seconds: 2),
                //                             );
                //                             ScaffoldMessenger.of(context)
                //                                 .showSnackBar(snackBar);
                //                           }
                //                         },
                //                         child: CustomBottomButton(
                //                           text: 'Find Drivers'.tr,
                //                           buttonColor: Color(0xffFFCC1B),
                //                           textColor: Colors.black,
                //                           borderColor: Color(0xffFFCC1B),
                //                         ),
                //                       ),
                //                     SizedBox(
                //                       height: 2.h,
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     :
                if (provider.load_find_driver == false)
                  Positioned(
                    bottom: 0.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  recovery_type = 1;
                                  setState(() {});
                                },
                                child: _buildOption(Icons.motorcycle, 'Sports',
                                    active: recovery_type == 1, count: 1),
                              ),
                              InkWell(
                                onTap: () {
                                  recovery_type = 2;
                                  setState(() {});
                                },
                                child: _buildOption(
                                  Icons.directions_car,
                                  'Normal',
                                  count: 4,
                                  active: recovery_type == 2,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  recovery_type = 3;
                                  setState(() {});
                                },
                                child: _buildOption(
                                  Icons.local_shipping,
                                  'Heavy',
                                  active: recovery_type == 3,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  recovery_type = 4;
                                  setState(() {});
                                },
                                child: _buildOption(
                                    Icons.luggage, 'Lightweight',
                                    active: recovery_type == 4, count: 4),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              selected_destination = 1;
                              _showRouteModal(context);
                            },
                            child: _buildInputField(
                                prefix: Icon(Icons.search, color: Colors.white),
                                hint: 'From',
                                nameWidget: controller_pickup.text.isEmpty
                                    ? null
                                    : SizedBox(
                                        height: 5.5.h,
                                        width: 100.w,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 16,
                                              width: 16,
                                              child: Center(
                                                child: Container(
                                                  height: 8,
                                                  width: 8,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      shape: BoxShape.circle),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFFCC1B),
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${controller_pickup.text}',
                                                style: TextStyle(
                                                    color: Color(0xffFFCC1B),
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              selected_destination = 2;
                              _showRouteModal(context);
                            },
                            child: _buildInputField(
                                prefix: Icon(Icons.search, color: Colors.white),
                                hint: 'To',
                                nameWidget: controller_drop_off.text.isEmpty
                                    ? null
                                    : SizedBox(
                                        height: 5.5.h,
                                        width: 100.w,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 16,
                                              width: 16,
                                              child: Center(
                                                child: Container(
                                                  height: 8,
                                                  width: 8,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      shape: BoxShape.circle),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${controller_drop_off.text}',
                                                style: TextStyle(
                                                    color: Color(0xffFFCC1B),
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                          ),
                          SizedBox(height: 10),
                          _buildInputField(
                            prefix: Text(
                                provider.totalFareModel == null
                                    ? 'AED'
                                    : 'Your Fare : AED ${provider.totalFareModel?.data?.totalCharges}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            hint: provider.totalFareModel == null
                                ? 'Your fare'
                                : '',
                            suffix: Icon(Icons.edit, color: Colors.white),
                          ),
                          SizedBox(height: 3.h),
                          SizedBox(
                            width: 100.w,
                            child: ElevatedButton(
                              onPressed: () {
                                if (pickup_latLng != null &&
                                    dropoff_latLng != null) {
                                  provider.find_driver_request(data: {
                                    "amount": provider
                                        .totalFareModel?.data?.totalCharges
                                        .toString(),
                                    "pick_up_lat":
                                        pickup_latLng!.latitude.toString(),
                                    "pick_up_long":
                                        pickup_latLng!.longitude.toString(),
                                    "drop_lat":
                                        dropoff_latLng!.latitude.toString(),
                                    "drop_long":
                                        dropoff_latLng!.longitude.toString(),
                                    "pickup_name": "${controller_pickup.text}",
                                    "drop_name": "${controller_drop_off.text}",
                                    "recovery_type": 2,
                                    'time':
                                        provider.totalFareModel?.data?.time ??
                                            '0',
                                    'distance': provider
                                            .totalFareModel?.data?.distance ??
                                        '0'
                                  });
                                  // int index_recovery = provider.recovery_type_model
                                  //     .indexWhere((element) =>
                                  //         element.typeName ==
                                  //         provider.selected_recovery_type);
                                  // provider.request_model = Request_Recovery_Model(
                                  //     lat1: pickup_latLng!.latitude.toString(),
                                  //     long1: pickup_latLng!.longitude.toString(),
                                  //     lat2: dropoff_latLng!.latitude.toString(),
                                  //     long2: dropoff_latLng!.longitude.toString(),
                                  //     plateNumber: 858,
                                  //     recoveryType: provider
                                  //         .recovery_type_model[index_recovery].id);
                                  // provider.calculate_fare();
                                } else {
                                  _showRouteModal(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: neonGreen,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Find a driver',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          )
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  top: 7.h,
                  left: 3.w,
                  child: GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.dehaze_rounded,
                        color: Color(0xffFFCC1B),
                        size: 30,
                      )),
                ),
                // Positioned(
                //   top: 11.h,
                //   left: 5.w,
                //   child: Container(
                //     height: 5.h,
                //     width: 44.w,
                //     decoration: BoxDecoration(
                //       color: Color(0xff181F30),
                //       border: selected_destination == 1
                //           ? Border.all(width: 4, color: Color(0xffFFCC1B))
                //           : Border.all(width: 4, color: Color(0xff181F30)),
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //     child: Row(
                //       children: [
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //         Image(
                //           image: AssetImage('assets/location.png'),
                //           height: 2.h,
                //         ),
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //         Expanded(
                //           child: Center(
                //             child: TextFormField(
                //               controller: controller_pickup,
                //               onTap: () {
                //                 print('click');
                //                 selected_destination = 1;
                //                 setState(() {});
                //               },
                //               style: TextStyle(
                //                   color: Colors.white, fontSize: 8.sp),
                //               onChanged: (v) {
                //                 print('result.......$v');
                //                 search_text = v;
                //                 setState(() {});
                //                 getNearbyPlaces(v);
                //               },
                //               decoration: InputDecoration(
                //                   hintText: 'Pickup Location'.tr,
                //                   isDense: true,
                //                   border: InputBorder.none,
                //                   hintStyle: TextStyle(
                //                       color: Colors.white, fontSize: 8.sp)),
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 3.w,
                //         ),
                //         if (controller_pickup.text.isNotEmpty)
                //           InkWell(
                //             child: SvgPicture.asset('assets/remove.svg'),
                //             onTap: () {
                //               search_text = '';
                //               controller_pickup.text = '';
                //               setState(() {});
                //             },
                //           ),
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Positioned(
                //   top: 11.h,
                //   right: 5.w,
                //   child: Container(
                //     height: 5.h,
                //     width: 44.w,
                //     decoration: BoxDecoration(
                //       color: Color(0xff181F30),
                //       //Colors.black,
                //       border: selected_destination == 2
                //           ? Border.all(width: 4, color: Color(0xffFFCC1B))
                //           : Border.all(width: 4, color: Color(0xff181F30)),
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //     child: Row(
                //       children: [
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //         Image(
                //           image: AssetImage('assets/location.png'),
                //           height: 2.h,
                //         ),
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //         Expanded(
                //           child: Center(
                //             child: TextFormField(
                //               controller: controller_drop_off,
                //               onTap: () {
                //                 selected_destination = 2;
                //                 setState(() {});
                //               },
                //               style: TextStyle(
                //                   color: Colors.white, fontSize: 8.sp),
                //               onChanged: (v) {
                //                 print('result.......$v');
                //                 search_text = v;
                //                 setState(() {});
                //                 getNearbyPlaces(v);
                //               },
                //               decoration: InputDecoration(
                //                   hintText: 'Drop-off Location'.tr,
                //                   isDense: true,
                //                   border: InputBorder.none,
                //                   hintStyle: TextStyle(
                //                       color: Colors.white, fontSize: 8.sp)),
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 3.w,
                //         ),
                //         if (controller_drop_off.text.isNotEmpty)
                //           InkWell(
                //             child: SvgPicture.asset('assets/remove.svg'),
                //             onTap: () {
                //               search_text = '';
                //               controller_drop_off.text = '';
                //               setState(() {});
                //             },
                //           ),
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                /*if (search_text.isNotEmpty)
                  Positioned(
                      top: 17.h,
                      child: Container(
                        height: 100.h,
                        width: 100.w,
                        child: ListView.builder(
                            itemBuilder: (c, i) {
                              return InkWell(
                                onTap: () {
                                  get_place_by_id(
                                      place_id: placesAutocompleteResponse!
                                          .predictions[i].placeId
                                          .toString(),
                                      name: placesAutocompleteResponse!
                                          .predictions[i].description!);
                                  search_text = '';
                                  setState(() {});
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 5),
                                    decoration:
                                        BoxDecoration(color: Colors.grey[100]!),
                                    child: ListTile(
                                      title: Text(
                                        '${placesAutocompleteResponse!.predictions[i].description!}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              );
                            },
                            padding: EdgeInsets.zero,
                            itemCount: placesAutocompleteResponse
                                    ?.predictions.length ??
                                0),
                        decoration: BoxDecoration(color: Colors.white),
                      )),*/
                if (provider.load_find_driver)
                  Positioned(
                    bottom: 0.h,
                    child: Container(
                      width: 100.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                Container(
                                  width: 10.w,
                                  height: 0.7.h,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  'Finding Drivers...',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  'Your Fare',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  'AED ${provider.totalFareModel?.data?.totalCharges}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                Text(
                                  'Travel Time : ${provider.totalFareModel?.data?.time}',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  width: 100.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Color(0xffFFD542),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            'Pickup Location',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.w),
                                        child: Text(
                                          '${provider.pickup_name}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  width: 100.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Color(0xffFFD542),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            'Drop_Off Location',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.w),
                                        child: Text(
                                          '${provider.dropoff_name}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // SharedPrefs sf = SharedPrefs();
                                    // var id = await sf.getid();
                                    provider.clear_info();
                                    // AuthRepository.instance.cancel_ride(body: {
                                    //   'request_id': model.id,
                                    //   'user_id': '${id}',
                                    //   'reason': ''
                                    // });
                                    navigationService
                                        .pushAndRemoveUntil(DropOffScreen());
                                  },
                                  child: Container(
                                    height: 6.h,
                                    width: 100.w,
                                    child: Center(
                                      child: Text(
                                        'Cancel Request',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1, color: Colors.red)),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  height: 4.h,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRouteModal(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Enter your route",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),

                  /// From field
                  Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: controller_pickup,
                          onTap: () {
                            print('click');
                            selected_destination = 1;
                            setState(() {});
                          },
                          onChanged: (v) async {
                            print('result.......$v');
                            search_text = v;
                            setState(() {});
                            getNearbyPlaces(v).then((v) {
                              setState(() {});
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "From",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[900],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),

                  /// To field
                  Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: controller_drop_off,
                          onTap: () {
                            selected_destination = 2;
                            setState(() {});
                          },
                          onChanged: (v) {
                            print('result.......$v');
                            search_text = v;
                            setState(() {});
                            getNearbyPlaces(v).then((v) {
                              setState(() {});
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "To",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[900],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  /// Choose on map
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => ChooseLocation(
                                map_style: isDaytime == true ? null : map_style,
                                selected_LatLng: (v) {
                                  getLocationAddress(latLng: v, add_name: true);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              )));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.place_outlined, color: Colors.blue),
                        SizedBox(width: 10),
                        Text("Choose on map",
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  /// Recent locations
                  Container(
                    height: 60.h,
                    width: 100.w,
                    child: ListView(
                      children: [
                        if (placesAutocompleteResponse != null)
                          ...placesAutocompleteResponse!.predictions.map((v) {
                            return ListTile(
                              onTap: () {
                                get_place_by_id(
                                    place_id: v.placeId.toString(),
                                    name: v.description!);
                                search_text = '';
                                setState(() {});
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.of(context).pop();
                              },
                              leading:
                                  Icon(Icons.access_time, color: Colors.grey),
                              title: Text('${v.description!}',
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final Color darkGray = Color(0xFF2E2E2E);
  final Color lightGray = Color(0xFF3A3A3A);
  final Color neonGreen = Color(0xffFFCC1B); // Close to neon

  void getLocationAddress(
      {required LatLng latLng,
      required bool? add_name,
      String? selected_name}) async {
    final AddRequestProvider provider = Provider.of<AddRequestProvider>(
        navigationService.navigatorKey.currentState!.context,
        listen: false);
    if (selected_destination == 1) {
      pickup_latLng = latLng;
    }
    if (selected_destination == 2) {
      dropoff_latLng = latLng;
    }
    String name = '';
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/location_marker.png', 100);
    if (selected_name == null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        name =
            '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
    }
    if (selected_destination == 1) {
      provider.pickup_name = selected_name ?? name;
      controller_pickup.text = selected_name ?? name;
    }
    if (selected_destination == 2) {
      provider.dropoff_name = selected_name ?? name;
      controller_drop_off.text = selected_name ?? name;
    }

    if (selected_destination == 1) {
      provider.markersList.remove('pickup_latLng');
      final markerId = MarkerId('pickup_latLng');
      final marker = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: MarkerId(UniqueKey().toString()),
        position: LatLng(pickup_latLng!.latitude, pickup_latLng!.longitude),
        infoWindow: InfoWindow(title: name),
      );
      final iceGiants = {markerId: marker};
      provider.markersList.addEntries(iceGiants.entries);
    }
    if (selected_destination == 2) {
      provider.markersList.remove('dropoff_latLng');
      final markerId = MarkerId('dropoff_latLng');
      final marker = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: MarkerId(UniqueKey().toString()),
        position: LatLng(dropoff_latLng!.latitude, dropoff_latLng!.longitude),
        infoWindow: InfoWindow(title: name),
      );
      final iceGiants = {markerId: marker};
      provider.markersList.addEntries(iceGiants.entries);
    }
    if (dropoff_latLng == null || pickup_latLng == null) {
      _controller!.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(latLng.latitude, latLng.longitude), 14.0));
    }
    if (dropoff_latLng != null && pickup_latLng != null) {
      print('step 1');
      await add_poly_line();
      print('step 2');

      Map<MarkerId, Marker> markersList2 = {};
      markersList2[MarkerId('pickup_latLng')] =
          provider.markersList[MarkerId('pickup_latLng')]!;
      markersList2[MarkerId('dropoff_latLng')] =
          provider.markersList[MarkerId('dropoff_latLng')]!;
      _controller!.animateCamera(
          CameraUpdate.newLatLngBounds(_bounds(markersList2), 150));
      print('step 3');
    }
    setState(() {});
    print('markersList length...${provider.markersList.length}');
    print(
        'markersList....${provider.markersList.length} $dropoff_latLng $pickup_latLng');
  }

  Widget dropContainer({String? image, String? text}) {
    return Container(
      height: 6.3.h,
      decoration: BoxDecoration(
        color: Color(0xff424755),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            Image(
              image: AssetImage(image!),
              height: 3.h,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              text!,
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String label,
      {bool active = false, int? count}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: active ? Color(0xffFFCC1B) : darkGray,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(10),
          child: Text(label,
              style: TextStyle(color: active ? Colors.black : Colors.white)),
        ),
      ],
    );
  }

  Future rate_dialog(
      {required BuildContext context,
      required Function(Map<String, dynamic>) rating_info}) async {
    double rating = 0;
    TextEditingController commentController = TextEditingController();
    await showMaterialModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: Color(0xffFFCC1B).withOpacity(0.5),
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Container(
            color: Color(0xffFFCC1B).withOpacity(0.5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 45.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Color(0xff181F30),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(children: [
                    Container(
                      height: 7.5.h,
                      child: Center(
                          child: Text(
                        'Rate Your Ride',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          unratedColor: Colors.white,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (value) {
                            rating = value;
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white, // Text color
                            ),
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: "Write a comment...",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              if (rating == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Please select a rating")),
                                );
                              } else {
                                String comment = commentController.text.trim();
                                // Submit rating and comment to your backend
                                print("Rating: $rating");
                                print("Comment: $comment");
                                rating_info.call(
                                    {'rating': rating, 'comment': '$comment'});
                                Navigator.of(context).pop(); // Close dialog
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              decoration: BoxDecoration(
                                  color: Color(0xffFFCC1B),
                                  borderRadius: BorderRadius.circular(30)),
                              height: 5.h,
                              width: 100.w,
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     if (rating == 0) {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text("Please select a rating")),
                          //       );
                          //     } else {
                          //       String comment = commentController.text.trim();
                          //       // Submit rating and comment to your backend
                          //       print("Rating: $rating");
                          //       print("Comment: $comment");
                          //       rating_info.call(
                          //           {'rating': rating, 'comment': '$comment'});
                          //       Navigator.of(context).pop(); // Close dialog
                          //     }
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor:
                          //         Color(0xffFFCC1B), // Background color
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 24, vertical: 12),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(
                          //           10), // Optional: Rounded corners
                          //     ),
                          //   ),
                          //   child: Text(
                          //     "Submit",
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            )),
      ),
    ).then((v) {
      Future.delayed(Duration(seconds: 5), () {
        show_rating = false;
      });
    });
  }

  Widget _buildInputField(
      {required Widget prefix,
      required String hint,
      Widget? suffix,
      Widget? nameWidget}) {
    return nameWidget != null
        ? nameWidget
        : Container(
            decoration: BoxDecoration(
              color: Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                prefix,
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (suffix != null) suffix,
              ],
            ),
          );
  }
}

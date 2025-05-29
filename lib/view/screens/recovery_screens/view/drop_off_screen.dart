import 'dart:io';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/bottom_button.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import 'package:yellowline/global_widgets/asset_to_unit8list.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../../../global_widgets/custom_drop_conatiner.dart';
import '../../home_page/drawer_screen.dart';
import '../model/request_recovery_model.dart';
import '../view_model/add_request_provider.dart';
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
        zoom: 13,
      )));
    });
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
  getNearbyPlaces(String keyword) async {
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
      "recoveryType": 2,
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
    provider.loading = false;
    provider.request_model = Request_Recovery_Model();
    provider.chargeUserResponceModel = null;
    provider.responce_fare_model = null;
    provider.selected_recovery_type = 'Normal';
    provider.pickup_name = '';
    provider.dropoff_name = '';
    provider.close_all_function();
    provider.markersList.clear();
    provider.totalFareModel = null;
    provider.allAvailableDrivers = null;
    provider.newBidDriverModel = [];
    provider.load_find_driver = false;
    super.deactivate();
  }

  String map_style = '';
  Future getMapStyle() async {
    map_style = await rootBundle.loadString('assets/map_style/dark_map.json');
    print('loaded map style');
    setState(() {});
  }

  bool? isDaytime;
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
                          child: map_style.isEmpty
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
                                  onTap: (v) {
                                    print('Clicked');
                                    getLocationAddress(
                                        latLng: v, add_name: true);
                                  },
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
                            height: 4.8.h,
                            width: 9.8.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Icon(Icons.zoom_in,
                                    size: 35, color: Color(0xff345eff))),
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
                            height: 4.8.h,
                            width: 9.8.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Icon(Icons.zoom_out_sharp,
                                    size: 35, color: Color(0xff345eff))),
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
                        height: 4.8.h,
                        width: 9.8.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)),
                        child: Center(
                            child: Icon(Icons.my_location_sharp,
                                size: 25, color: Color(0xff345eff))),
                      ),
                    )),
                if (provider.totalFareModel != null)
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
                                  width: 20.w,
                                  height: 1.h,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  'Your Fare',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey),
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
                                if (!provider.load_find_driver)
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                if (!provider.load_find_driver)
                                  InkWell(
                                    onTap: () {
                                      if (pickup_latLng != null &&
                                          dropoff_latLng != null) {
                                        provider.find_driver_request(data: {
                                          "amount": provider.totalFareModel
                                              ?.data?.totalCharges
                                              .toString(),
                                          "pick_up_lat": pickup_latLng!.latitude
                                              .toString(),
                                          "pick_up_long": pickup_latLng!
                                              .longitude
                                              .toString(),
                                          "drop_lat": dropoff_latLng!.latitude
                                              .toString(),
                                          "drop_long": dropoff_latLng!.longitude
                                              .toString(),
                                          "pickup_name":
                                              "${controller_pickup.text}",
                                          "drop_name":
                                              "${controller_drop_off.text}",
                                          "recovery_type": 2,
                                          'time': provider
                                                  .totalFareModel?.data?.time ??
                                              '0',
                                          'distance': provider.totalFareModel
                                                  ?.data?.distance ??
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
                                        var snackBar = SnackBar(
                                          content: Text(
                                              'Please select pickup and drop of location first'),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: CustomBottomButton(
                                      text: 'Find Drivers'.tr,
                                      buttonColor: Color(0xffFFCC1B),
                                      textColor: Colors.black,
                                      borderColor: Color(0xffFFCC1B),
                                    ),
                                  ),
                                SizedBox(
                                  height: 2.h,
                                )
                              ],
                            ),
                          ),
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
                Positioned(
                  top: 11.h,
                  left: 5.w,
                  child: Container(
                    height: 5.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      color: Color(0xff181F30),
                      border: selected_destination == 1
                          ? Border.all(width: 4, color: Color(0xffFFCC1B))
                          : Border.all(width: 4, color: Color(0xff181F30)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2.w,
                        ),
                        Image(
                          image: AssetImage('assets/location.png'),
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Expanded(
                          child: Center(
                            child: TextFormField(
                              controller: controller_pickup,
                              onTap: () {
                                print('click');
                                selected_destination = 1;
                                setState(() {});
                              },
                              style: TextStyle(
                                  color: Colors.white, fontSize: 8.sp),
                              onChanged: (v) {
                                print('result.......$v');
                                search_text = v;
                                setState(() {});
                                getNearbyPlaces(v);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Pickup Location'.tr,
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 8.sp)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        if (controller_pickup.text.isNotEmpty)
                          InkWell(
                            child: SvgPicture.asset('assets/remove.svg'),
                            onTap: () {
                              search_text = '';
                              controller_pickup.text = '';
                              setState(() {});
                            },
                          ),
                        SizedBox(
                          width: 2.w,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 11.h,
                  right: 5.w,
                  child: Container(
                    height: 5.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      color: Color(0xff181F30),
                      //Colors.black,
                      border: selected_destination == 2
                          ? Border.all(width: 4, color: Color(0xffFFCC1B))
                          : Border.all(width: 4, color: Color(0xff181F30)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 2.w,
                        ),
                        Image(
                          image: AssetImage('assets/location.png'),
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Expanded(
                          child: Center(
                            child: TextFormField(
                              controller: controller_drop_off,
                              onTap: () {
                                selected_destination = 2;
                                setState(() {});
                              },
                              style: TextStyle(
                                  color: Colors.white, fontSize: 8.sp),
                              onChanged: (v) {
                                print('result.......$v');
                                search_text = v;
                                setState(() {});
                                getNearbyPlaces(v);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Drop-off Location'.tr,
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 8.sp)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        if (controller_drop_off.text.isNotEmpty)
                          InkWell(
                            child: SvgPicture.asset('assets/remove.svg'),
                            onTap: () {
                              search_text = '';
                              controller_drop_off.text = '';
                              setState(() {});
                            },
                          ),
                        SizedBox(
                          width: 2.w,
                        ),
                      ],
                    ),
                  ),
                ),
                if (search_text.isNotEmpty)
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
                      )),
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
                                  onTap: () {
                                    Navigator.of(context).pop();
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

  void getLocationAddress(
      {required LatLng latLng,
      required bool? add_name,
      String? selected_name}) async {
    final AddRequestProvider provider =
        Provider.of<AddRequestProvider>(context, listen: false);
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
      name = '${placemarks[0].name ?? ''}';
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
      _controller!.animateCamera(
          CameraUpdate.newLatLngBounds(_bounds(provider.markersList), 150));
      print('step 3');
    }
    setState(() {});
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
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../global_widgets/asset_to_unit8list.dart';
import '../../../../../global_widgets/cupertino_alert_dialog.dart';
import '../../../../../global_widgets/custom_drop_conatiner.dart';
import '../../../../../global_widgets/maps_sheet.dart';
import '../../../../global_widgets/data_loading.dart';
import '../../home_page/home_screen.dart';
import '../model/my_pending_request_model.dart';

class MyPendingRequestMapView extends StatefulWidget {
  final LatLng pickup_latLng;
  final LatLng dropoff_latLng;
  final PendingRequestModel driverRequestModel;
  final Function(String) cancel_request;
  const MyPendingRequestMapView(
      {super.key,
      required this.pickup_latLng,
      required this.dropoff_latLng,
      required this.driverRequestModel,
      required this.cancel_request});

  @override
  State<MyPendingRequestMapView> createState() =>
      _MyPendingRequestMapViewState();
}

class _MyPendingRequestMapViewState extends State<MyPendingRequestMapView> {
  Map<PolylineId, Polyline> polylines = {};
  GoogleMapController? _controller;
  var markersList = <MarkerId, Marker>{};
  LatLng? pickup_latLng;
  LatLng? dropoff_latLng;
  void onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    add_poly_line(position);
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

  add_poly_line(Position position) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result1 = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyAoknLjF2XNcjPDW25O5QOQFLgdVKc6GgU',
        PointLatLng(position.latitude, position.longitude),
        PointLatLng(pickup_latLng!.latitude, pickup_latLng!.longitude));
    PolylineResult result2 = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyAoknLjF2XNcjPDW25O5QOQFLgdVKc6GgU',
        PointLatLng(pickup_latLng!.latitude, pickup_latLng!.longitude),
        PointLatLng(dropoff_latLng!.latitude, dropoff_latLng!.longitude));
    if (result1.points.isNotEmpty) {
      result1.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    if (result2.points.isNotEmpty) {
      result2.points.forEach((PointLatLng point) {
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
    add_Marker(position);
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

  add_Marker(Position position) async {
    final Uint8List markerIcon1 =
        await getBytesFromAsset('assets/location_marker.png', 100);
    final Uint8List markerIcon2 =
        await getBytesFromAsset('assets/location_marker2.png', 100);
    final Uint8List markerIcon3 =
        await getBytesFromAsset('assets/car_icon.png', 150);

    ///1
    markersList.remove('pickup_latLng');
    final markerId1 = MarkerId('pickup_latLng');
    final marker1 = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon3),
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(pickup_latLng!.latitude, pickup_latLng!.longitude),
    );
    final iceGiants1 = {markerId1: marker1};
    markersList.addEntries(iceGiants1.entries);
    markersList.remove('dropoff_latLng');

    ///2
    final markerId2 = MarkerId('dropoff_latLng');
    final marker2 = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon1),
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(dropoff_latLng!.latitude, dropoff_latLng!.longitude),
    );
    final iceGiants2 = {markerId2: marker2};
    markersList.addEntries(iceGiants2.entries);

    ///3
    markersList.remove('driver_coordinate');
    final markerId3 = MarkerId('driver_coordinate');
    final marker3 = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon2),
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(position.latitude, position.longitude),
    );
    final iceGiants3 = {markerId3: marker3};
    markersList.addEntries(iceGiants3.entries);
    _controller!
        .animateCamera(CameraUpdate.newLatLngBounds(_bounds(markersList), 150));
    setState(() {});
  }

  @override
  void initState() {
    stop_pending_request_routing = true;
    pickup_latLng = widget.pickup_latLng;
    dropoff_latLng = widget.dropoff_latLng;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      panelcontroller.animatePanelToPosition(1,
          duration: Duration(milliseconds: 600));
    });
    super.initState();
  }

  get_current_location() async {
    Position position = await requestLocation();
    await _controller!
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 15.7,
    )));
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

  double panelHeightOpen = 50.h;
  double panelHeightClosed = 6.h;
  double fabHeight = 0;
  final double initFabHeight = 50.h;
  final PanelController panelcontroller = PanelController();
  bool load = false;

  @override
  void dispose() {
    stop_pending_request_routing = false;
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: DataLoading(
          isLoading: load,
          child: Container(
            height: 100.h,
            width: 100.w,
            child: Stack(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(19.0760, 72.8777),
                      zoom: 15.7,
                    ),
                    cloudMapId: Platform.isIOS
                        ? '9ade47e7d53ff36d'
                        : '8cc3ed800b9e0615',
                    polylines: Set<Polyline>.of(polylines.values),
                    onMapCreated: (controller) {
                      //customInfoWindowController.googleMapController = controller;
                      // if (markers.isNotEmpty) {
                      //   print('total markers = ${markers.length}');
                      //   controller.animateCamera(CameraUpdate.newLatLngBounds(
                      //       _bounds(markers), 50.0));
                      // }
                      onMapCreated(controller);
                    },
                    onCameraMove: (position) {
                      //customInfoWindowController.onCameraMove!();
                    },
                    myLocationButtonEnabled: false,
                    myLocationEnabled: false,
                    markers: Set<Marker>.of(markersList.values),
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
                SlidingUpPanel(
                  controller: panelcontroller,
                  maxHeight: panelHeightOpen,
                  minHeight: panelHeightClosed,
                  parallaxOffset: 1,
                  boxShadow: [],
                  panelBuilder: (sc) => Container(
                    width: 100.w,
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                        color: Color(0xff181F30),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 0.5.h,
                                width: 12.w,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius: BorderRadius.circular(30))),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Live Tracking:'.tr,
                              style: TextStyle(
                                  fontSize: 11.sp, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () async {
                                final Uri launchUri = Uri(
                                    scheme: 'tel',
                                    path:
                                        '${widget.driverRequestModel.driverDialCode}${widget.driverRequestModel.driverMobile}');
                                if (await canLaunchUrl(launchUri)) {
                                  await launchUrl(launchUri);
                                } else {
                                  throw 'Could not launch $launchUri';
                                }
                              },
                              child: Container(
                                height: 4.h,
                                width: 12.w,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFD542),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Icon(
                                    Icons.call,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            CustomDropContainer(
                              height: 5.4.h,
                              width: 30.w,
                              text: 'Reaching in'.tr,
                              texxt: '${widget.driverRequestModel.time}',
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            CustomDropContainer(
                              height: 5.4.h,
                              width: 30.w,
                              text: 'Distance'.tr,
                              texxt: '${widget.driverRequestModel.distance} km',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Pickup : ${widget.driverRequestModel.pickupName}".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Drop : ${widget.driverRequestModel.dropName}".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  MapsSheet.show(
                                    context: context,
                                    onMapTap: (map) {
                                      map.showMarker(
                                        coords: Coords(
                                            double.parse(widget
                                                .driverRequestModel.pickUpLat),
                                            double.parse(widget
                                                .driverRequestModel
                                                .pickUpLong)),
                                        title:
                                            '${widget.driverRequestModel.pickupName}',
                                        zoom: 15,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.directions),
                                      Text(
                                        'Pickup Location'.tr,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFD542),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  MapsSheet.show(
                                    context: context,
                                    onMapTap: (map) {
                                      map.showMarker(
                                        coords: Coords(
                                            double.parse(widget
                                                .driverRequestModel.dropLat),
                                            double.parse(widget
                                                .driverRequestModel.dropLong)),
                                        title:
                                            '${widget.driverRequestModel.dropName}',
                                        zoom: 15,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.directions),
                                      Text(
                                        'Drop-off Location'.tr,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFD542),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // show_cupertinoDialog(
                                  //     context: context,
                                  //     title: 'Cancel Request?'.tr,
                                  //     subtitle:
                                  //         'Are you sure you want to cancel the request'
                                  //             .tr,
                                  //     no_subtitle: 'No',
                                  //     yes_title: "Yes",
                                  //     on_done: () async {
                                  //       widget.cancel_request.call();
                                  //       load = true;
                                  //       setState(() {});
                                  //       // await DriverRepository.instance
                                  //       //     .update_request_status(body: {
                                  //       //   "driver_id":
                                  //       //       '${widget.driverRequestModel.driverId}',
                                  //       //   "request_id":
                                  //       //       '${widget.driverRequestModel.id}',
                                  //       //   "request_status": "1"
                                  //       // });
                                  //       // load = false;
                                  //       // setState(() {});
                                  //       // Navigator.of(context).pop();
                                  //     });
                                  showCancelRideDialog(context);
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Center(
                                    child: Text(
                                      'Cancel'.tr,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFD542),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  onPanelSlide: (double pos) => setState(() {
                    fabHeight = pos * (panelHeightOpen - panelHeightClosed) +
                        initFabHeight;
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCancelRideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedReason;
        List<String> reasons = [
          "Driver is taking too long",
          "Changed my mind",
          "Wrong pickup location",
          "Booked by mistake",
          "Driver asked to cancel",
          "Other"
        ];

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text("Cancel Ride",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...reasons.map((reason) => RadioListTile<String>(
                          title: Text(reason),
                          value: reason,
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = value;
                            });
                          },
                        )),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Text("Close"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedReason != null) {
                      // Call your cancel ride function here
                      print("Ride cancelled for reason: $selectedReason");
                      Navigator.of(context).pop();
                      widget.cancel_request.call("$selectedReason");
                      load = true;
                      setState(() {});
                    } else {
                      // Optionally show a warning to select a reason
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a reason")),
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

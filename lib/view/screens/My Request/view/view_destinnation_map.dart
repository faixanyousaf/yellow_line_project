import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../../../../../global_widgets/custom_drop_conatiner.dart';
import '../../recovery_screens/view/asset_to_unit8list.dart';

class ViewDestinationMap extends StatefulWidget {
  final LatLng pickup_latLng;
  final LatLng dropoff_latLng;
  const ViewDestinationMap(
      {super.key, required this.pickup_latLng, required this.dropoff_latLng});

  @override
  State<ViewDestinationMap> createState() => _ViewDestinationMapState();
}

class _ViewDestinationMapState extends State<ViewDestinationMap> {
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
    pickup_latLng = widget.pickup_latLng;
    dropoff_latLng = widget.dropoff_latLng;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Container(
              height: 80.h,
              width: 100.w,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(19.0760, 72.8777),
                  zoom: 15.7,
                ),
                cloudMapId:
                Platform.isIOS ? '9ade47e7d53ff36d' : '8cc3ed800b9e0615',
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
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                myLocationEnabled: false,
                markers: Set<Marker>.of(markersList.values),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 25.h,
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
                    Text(
                      'Live Tracking:',
                      style: TextStyle(fontSize: 11.sp, color: Colors.white),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        CustomDropContainer(
                          height: 5.4.h,
                          width: 30.w,
                          text: 'Reaching in',
                          texxt: '10 min',
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        CustomDropContainer(
                          height: 5.4.h,
                          width: 30.w,
                          text: 'Distance',
                          texxt: '10 km',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            final link = WhatsAppUnilink(
                              phoneNumber: '+001-(555)1234567',
                              text: "",
                            );
                            await launchUrl(link.asUri());
                          },
                          child: Container(
                            height: 6.h,
                            width: 40.w,
                            child: Center(
                              child: Text(
                                'WhatsApp',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff0CC243),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("tel://21213123123"));
                          },
                          child: Container(
                            height: 6.h,
                            width: 40.w,
                            child: Center(
                              child: Text(
                                'Call',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xffFFD542),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
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
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xffFFCC1B),
                    size: 5.w,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

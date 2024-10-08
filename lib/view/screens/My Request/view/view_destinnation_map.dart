import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:yellowline/helper/navigation/navigation_object.dart';
import 'package:yellowline/helper/navigation/router_path.dart';
import '../../../../../global_widgets/asset_to_unit8list.dart';
import '../../../../../global_widgets/custom_drop_conatiner.dart';
import '../../../../core/network/routes/base_url.dart';
import '../../../../global_widgets/data_loading.dart';
import '../model/view_request_model.dart';

class ViewDestinationMap extends StatefulWidget {
  final LatLng pickup_latLng;
  final LatLng dropoff_latLng;
  final ViewRequestModel driverRequestModel;
  const ViewDestinationMap(
      {super.key,
      required this.pickup_latLng,
      required this.dropoff_latLng,
      required this.driverRequestModel});

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
    print('${'driverLat...${widget.driverRequestModel.driverLat}'}');
    print('${'driverLong...${widget.driverRequestModel.driverLong}'}');
    add_poly_line(
        widget.driverRequestModel.driverLat == null
            ? null
            : LatLng(double.parse('${widget.driverRequestModel.driverLat}'),
                double.parse('${widget.driverRequestModel.driverLong}')),
        animate_camera: true);
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

  add_poly_line(LatLng? position, {bool? animate_camera = false}) async {
    if (position == null) {
      List<LatLng> polylineCoordinates = [];
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result1 = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyAoknLjF2XNcjPDW25O5QOQFLgdVKc6GgU',
          PointLatLng(pickup_latLng!.latitude, pickup_latLng!.longitude),
          PointLatLng(dropoff_latLng!.latitude, dropoff_latLng!.longitude));
      if (result1.points.isNotEmpty) {
        result1.points.forEach((PointLatLng point) {
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
      add_Marker(position, animate_camera: animate_camera);
    } else {
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
      add_Marker(position, animate_camera: animate_camera);
    }
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

  int numDeltas = 50;
  double? deltaLat;
  double? deltaLng;
  var driver_position;
  var i = 0;
  Uint8List? markerIcon2;
  bool add_action = false;
  add_Marker(LatLng? position, {bool? animate_camera}) async {
    final Uint8List markerIcon1 =
        await getBytesFromAsset('assets/location_marker.png', 100);
    markerIcon2 = await getBytesFromAsset('assets/location_marker2.png', 100);
    final Uint8List markerIcon3 =
        await getBytesFromAsset('assets/car_icon.png', 150);

    ///1
    markersList.remove('pickup_latLng');
    final markerId1 = MarkerId('pickup_latLng');
    final marker1 = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon3),
        markerId: markerId1,
        position: LatLng(pickup_latLng!.latitude, pickup_latLng!.longitude));
    final iceGiants1 = {markerId1: marker1};
    markersList.addEntries(iceGiants1.entries);

    ///2
    markersList.remove('dropoff_latLng');
    final markerId2 = MarkerId('dropoff_latLng');
    final marker2 = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon1),
        markerId: markerId2,
        position: LatLng(dropoff_latLng!.latitude, dropoff_latLng!.longitude));
    final iceGiants2 = {markerId2: marker2};
    markersList.addEntries(iceGiants2.entries);

    ///3
    if (position != null) {
      if (!markersList.containsKey(MarkerId('driver_coordinate'))) {
        print('has coordiate');
        driver_position = [position.latitude, position.longitude];
        final markerId3 = MarkerId('driver_coordinate');
        final marker3 = Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon2!),
          markerId: markerId3,
          position: LatLng(position.latitude, position.longitude),
        );
        final iceGiants3 = {markerId3: marker3};
        markersList.addEntries(iceGiants3.entries);
        print('animate_camera call');
        _controller!.animateCamera(
            CameraUpdate.newLatLngBounds(_bounds(markersList), 150));
      }
      if (animate_camera == true) {
        print('animate_camera call');
        add_action = true;
        _controller!.animateCamera(
            CameraUpdate.newLatLngBounds(_bounds(markersList), 150));
      }
    } else {
      print('animate_camera call');
      add_action = true;
      _controller!.animateCamera(
          CameraUpdate.newLatLngBounds(_bounds(markersList), 150));
    }
    setState(() {});
  }

  void _animateMarker(LatLng start, LatLng end) async {
    print('call animate');
    const int steps = 60;
    const Duration duration = Duration(milliseconds: 1);
    final double deltaLat = (end.latitude - start.latitude) / steps;
    final double deltaLng = (end.longitude - start.longitude) / steps;
    for (int i = 1; i <= steps; i++) {
      print('animate');
      final double newLat = start.latitude + deltaLat * i;
      final double newLng = start.longitude + deltaLng * i;
      setState(() {
        LatLng position = LatLng(newLat, newLng);
        Marker? m = markersList[MarkerId('driver_coordinate')];
        markersList[MarkerId('driver_coordinate')] = m!.copyWith(
          positionParam: position,
        );
      });
      await Future.delayed(duration ~/ steps);
    }
  }

  String map_style = '';
  Future getMapStyle() async {
    map_style = await rootBundle.loadString('assets/map_style/dark_map.json');
    print('loaded map style');
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
    print('${widget.driverRequestModel.toJson()}');
    pickup_latLng = widget.pickup_latLng;
    dropoff_latLng = widget.dropoff_latLng;
    if (widget.driverRequestModel.status == 4) {
      panelHeightOpen = 42.h;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      panelcontroller.animatePanelToPosition(1,
          duration: Duration(milliseconds: 600));
    });
    connect_web_socket();
    super.initState();
  }

  WebSocketChannel? channel;
  connect_web_socket() async {
    final wsUrl = Uri.parse('${socket_url}');
    channel = WebSocketChannel.connect(wsUrl);
    await channel!.ready;
    channel!.stream.listen((message) async {
      if (add_action) {
        print('call socket');
        print('${message}');
        Map map = jsonDecode(message);
        if ('${map['driver_id']}' ==
            widget.driverRequestModel.driverId.toString()) {
          if (markersList.containsKey(MarkerId('driver_coordinate'))) {
            _animateMarker(
                LatLng(driver_position[0], driver_position[1]),
                LatLng(double.parse('${map['lat']}'),
                    double.parse('${map['lng']}')));
            driver_position = [
              double.parse('${map['lat']}'),
              double.parse('${map['lng']}')
            ];
          }
          add_poly_line(LatLng(
              double.parse('${map['lat']}'), double.parse('${map['lng']}')));
        }
      }
    });
  }

  get_current_location() async {
    Position position = await requestLocation();
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
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

  double panelHeightOpen = 37.h;
  double panelHeightClosed = 6.h;
  double fabHeight = 0;
  final double initFabHeight = 50.h;
  final PanelController panelcontroller = PanelController();
  bool load = false;

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: map_style.isEmpty
                    ? SizedBox()
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(19.0760, 72.8777),
                          zoom: 15.7,
                        ),
                        style: isDaytime == true ? null : map_style,
                        polylines: Set<Polyline>.of(polylines.values),
                        onMapCreated: (controller) {
                          onMapCreated(controller);
                        },
                        markers: markersList.values.toSet(),
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                      ),
              ),
              Positioned(
                  bottom: 10.h,
                  right: 5.w,
                  child: FloatingActionButton(
                    onPressed: () {
                      get_current_location();
                    },
                    child: Icon(Icons.my_location),
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
                      Text(
                        'Live Tracking:'.tr,
                        style: TextStyle(fontSize: 11.sp, color: Colors.white),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          CustomDropContainer(
                            height: 5.6.h,
                            width: 30.w,
                            text: 'Reaching in'.tr,
                            texxt: '10 min',
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          CustomDropContainer(
                            height: 5.6.h,
                            width: 30.w,
                            text: 'Distance'.tr,
                            texxt: '10 km',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'Driver detail:'.tr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      if (widget.driverRequestModel.driverLat != null)
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                navigationService.navigateTo(
                                    RouterPath.DriverProfileScreen,
                                    arguments:
                                        '${widget.driverRequestModel.driverId}');
                              },
                              child: CircleAvatar(
                                radius: 3.0.h,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  child: Icon(
                                    Icons.person,
                                    size: 35,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              '${widget.driverRequestModel.driverName}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            InkWell(
                              onTap: () async {
                                final link = WhatsAppUnilink(
                                  phoneNumber:
                                      '${widget.driverRequestModel.driverDialCode}${widget.driverRequestModel.driverMobile}',
                                  text: "",
                                );
                                await launchUrl(link.asUri());
                              },
                              child: SizedBox(
                                child: Image.asset('assets/whats_app.png'),
                                height: 4.h,
                                width: 8.w,
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            InkWell(
                              onTap: () {
                                launchUrl(Uri.parse(
                                    "tel://${widget.driverRequestModel.driverDialCode}${widget.driverRequestModel.driverMobile}"));
                              },
                              child: SizedBox(
                                child: Image.asset('assets/call_icon.png'),
                                height: 4.h,
                                width: 8.w,
                              ),
                            ),
                          ],
                        ),
                      if (widget.driverRequestModel.driverLat == null)
                        Text(
                          'Driver did not assign!'.tr,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

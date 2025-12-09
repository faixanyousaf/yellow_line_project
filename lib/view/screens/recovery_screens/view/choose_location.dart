import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sizer/sizer.dart';

class ChooseLocation extends StatefulWidget {
  final String? map_style;
  final Function(LatLng)? selected_LatLng;
  const ChooseLocation({super.key, this.map_style, this.selected_LatLng});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  GoogleMapController? _controller;
  LatLng? pickup_latLng;
  LatLng? dropoff_latLng;
  int selected_destination = 1;
  void onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    _gotoPosition();
  }

  LatLng? current_lat_lng;
  void _gotoPosition({bool? move_camera = true}) async {
    final position = await requestLocation();
    Future.delayed(Duration(seconds: 1), () async {
      await _controller!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      )));
    });
    current_lat_lng = LatLng(position.latitude, position.longitude);
    setState(() {});
    getPlace_name(current_lat_lng!);
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

  String? place_name;
  getPlace_name(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      final Placemark place = placemarks.first;
      place_name =
          '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      setState(() {});
    }
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          "Choose Location",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              height: 100.h,
              width: 100.w,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(19.0760, 72.8777),
                  zoom: 22,
                ),
                style: widget.map_style,
                onMapCreated: (controller) {
                  onMapCreated(controller);
                },
                markers: {
                  if (current_lat_lng != null)
                    Marker(
                      markerId: MarkerId("selected-location"),
                      position: current_lat_lng!,
                      infoWindow: InfoWindow(
                          title: "Jhangi Wala Rd", snippet: 'addmarker'),
                    ),
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                onTap: (v) {
                  current_lat_lng = v;
                  setState(() {});
                  getPlace_name(current_lat_lng!);
                },
              )),
          Positioned(
              top: 5.h,
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
              top: 18.h,
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
          if (place_name != null)
            Positioned(
                child: SizedBox(
                  width: 100.w,
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      child: Center(child: Text('${place_name}')),
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                ),
                bottom: 12.h),
          Positioned(
              bottom: 5.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: InkWell(
                  onTap: () {
                    widget.selected_LatLng!.call(current_lat_lng!);
                  },
                  child: Container(
                    height: 6.h,
                    width: 90.w,
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffFFCC1B),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

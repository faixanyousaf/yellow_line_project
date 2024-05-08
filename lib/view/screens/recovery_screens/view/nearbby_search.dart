import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:sizer/sizer.dart';
import '../../../../global_widgets/bottom_button.dart';
import '../../../../global_widgets/distance_calculator.dart';

class GoogleNearbySearch extends StatefulWidget {
  final String? name;
  final LatLng? latLng;
  const GoogleNearbySearch(
      {super.key, required this.name, required this.latLng});

  @override
  State<GoogleNearbySearch> createState() => _GoogleNearbySearchState();
}

class _GoogleNearbySearchState extends State<GoogleNearbySearch> {
  PlacesSearchResponse? place_detail;
  var kGoogleApiKey = 'AIzaSyAoknLjF2XNcjPDW25O5QOQFLgdVKc6GgU';
  get_place_by_id() async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());
    place_detail = await places.searchNearbyWithRadius(
      Location(lat: widget.latLng!.latitude, lng: widget.latLng!.longitude),
      5000,
      keyword: '${widget.name}',
      //name: '${widget.name}',
      //type: '${widget.name}'
    );
    setState(() {});
  }

  @override
  void initState() {
    get_place_by_id();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181F30),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '${widget.name}',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemBuilder: (c, i) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child:
                            Image.network('${place_detail?.results[i].icon}'),
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${place_detail?.results[i].name}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${calculateDistance(lat1: widget.latLng!.latitude, lon1: widget.latLng!.longitude, lat2: place_detail?.results[i].geometry!.location.lat, lon2: place_detail?.results[i].geometry!.location.lng)} km',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      RatingBar.builder(
                        initialRating: double.parse(
                            '${place_detail?.results[i].rating ?? 0.0}'),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop({
                          'latlng': LatLng(
                              place_detail?.results[i].geometry!.location.lat ??
                                  0.0,
                              place_detail?.results[i].geometry!.location.lng ??
                                  0.0),
                          'name': place_detail?.results[i].name,
                          'as': 1
                        });
                      },
                      child: CustomBottomButton(
                        text: 'Pickup'.tr,
                        height: 4.h,
                        buttonColor: Color(0xffFFCC1B),
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        font_size: 9,
                      ),
                    )),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop({
                          'latlng': LatLng(
                              place_detail?.results[i].geometry!.location.lat ??
                                  0.0,
                              place_detail?.results[i].geometry!.location.lng ??
                                  0.0),
                          'name': place_detail?.results[i].name,
                          'as': 2
                        });
                      },
                      child: CustomBottomButton(
                        text: 'Drop-off'.tr,
                        height: 4.h,
                        font_size: 9,
                        buttonColor: Color(0xffFFCC1B),
                        textColor: Colors.black,
                        borderColor: Colors.black,
                      ),
                    )),
                    SizedBox(
                      width: 3.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.5.h,
                ),
              ],
            ),
          );
        },
        itemCount: place_detail?.results.length ?? 0,
      ),
    );
  }
}

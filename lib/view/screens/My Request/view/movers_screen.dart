import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/data_loading.dart';

import '../view_model/view_request_provider.dart';
import 'view_destinnation_map.dart';

class MoversScreen extends StatefulWidget {
  final int status;
  const MoversScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<MoversScreen> createState() => _MoversScreenState();
}

class _MoversScreenState extends State<MoversScreen> {
  DateFormat dt = DateFormat('dd MMMM yyyy');
  @override
  void initState() {
    final ViewRequestProvider provider =
        Provider.of<ViewRequestProvider>(context, listen: false);
    provider.get_request_data(status: widget.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ViewRequestProvider provider =
        Provider.of<ViewRequestProvider>(context);
    return DataLoading(
      isLoading: provider.loading,
      use_opacity: false,
      child: Container(
        height: 100.h,
        width: 100.w,
        child: ListView.builder(
          itemCount: provider.viewRequestModel.length,
          padding: EdgeInsets.only(top: 2.h),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (c) => ViewDestinationMap(
                            driverRequestModel:
                                provider.viewRequestModel[index],
                            dropoff_latLng: LatLng(
                                double.parse(
                                    provider.viewRequestModel[index].dropLat ??
                                        '0.0'),
                                double.parse(
                                    provider.viewRequestModel[index].dropLong ??
                                        '0.0')),
                            pickup_latLng: LatLng(
                                double.parse(provider
                                        .viewRequestModel[index].pickUpLat ??
                                    '0.0'),
                                double.parse(provider
                                        .viewRequestModel[index].pickUpLong ??
                                    '0.0')),
                          )))
                  .then((v) {
                provider.get_request_data(status: widget.status);
              });
            },
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  child: Stack(
                    children: [
                      Center(
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: [6],
                          radius: Radius.circular(20),
                          strokeWidth: 1.3,
                          color: Color(0xffFFCC1B),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 85.w,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Text(
                                        '${dt.format(DateTime.parse("${provider.viewRequestModel[index].createdAt}"))}',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    Text(
                                        'ID: ${provider.viewRequestModel[index].id} | AED${provider.viewRequestModel[index].amount}',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Color(0xff13F01C))),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset('assets/svgs/dot.svg'),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                            '${provider.viewRequestModel[index].pickupName}',
                                            style: TextStyle(
                                                fontSize: 8.sp,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/locy.svg'),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                            '${provider.viewRequestModel[index].dropName}',
                                            style: TextStyle(
                                                fontSize: 8.sp,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.3.h,
                                    ),
                                    if (widget.status == 4 &&
                                        provider.viewRequestModel[index]
                                                .rated !=
                                            'true')
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            Rating_dialog(
                                                context: context,
                                                no_call: () {},
                                                done_call: (v) {
                                                  provider.rate_driver(body: {
                                                    "driver_id": provider
                                                        .viewRequestModel[index]
                                                        .driverId,
                                                    "request_id": provider
                                                        .viewRequestModel[index]
                                                        .id,
                                                    "rating": v
                                                  }, status: widget.status);
                                                });
                                          },
                                          child: Container(
                                            height: 3.h,
                                            width: 20.w,
                                            decoration: BoxDecoration(
                                                color: Color(0xffFFCC1B),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                              child: Text(
                                                'Add Rating',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (widget.status == 4 &&
                                        provider.viewRequestModel[index]
                                                .rated ==
                                            'true')
                                      Center(
                                        child: RatingBar(
                                          initialRating: double.parse(
                                              '${provider.viewRequestModel[index].averageRating ?? 0}'),
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          ignoreGestures: true,
                                          itemCount: 5,
                                          itemSize: 5.w,
                                          ratingWidget: RatingWidget(
                                            full: SvgPicture.asset(
                                              'assets/svgs/rating_icon_fill.svg',
                                              color: Color(0xffFFCC1B),
                                            ),
                                            empty: SvgPicture.asset(
                                              'assets/svgs/rating_icon.svg',
                                              color: Color(0xffFFCC1B),
                                            ),
                                            half: SvgPicture.asset(
                                              'assets/svgs/rating_icon.svg',
                                              color: Color(0xffFFCC1B),
                                            ),
                                          ),
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          onRatingUpdate: (rnt) {},
                                        ),
                                      ),
                                    if (widget.status == 4)
                                      SizedBox(
                                        height: 1.3.h,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 3.w,
                          top: 4.5.h,
                          child: SvgPicture.asset(
                              'assets/svgs/yellow_arrrow.svg')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future Rating_dialog(
    {BuildContext? context,
    Function(double)? done_call,
    Function()? no_call}) async {
  double rating = 0.0;
  await showMaterialModalBottomSheet(
    context: context!,
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
                height: 40.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(children: [
                  Container(
                    height: 7.5.h,
                    child: Center(
                        child: Text(
                      'Rate itinerary',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    )),
                    decoration: BoxDecoration(
                        color: Color(0xffD1E3F4),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Center(
                      child: Text(
                    'Provide the Ratings based on how you like this \nItinerary.',
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                    child: Center(
                      child: RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: SvgPicture.asset(
                            'assets/svgs/rating_icon_fill.svg',
                            color: Color(0xffFFCC1B),
                          ),
                          empty: SvgPicture.asset(
                            'assets/svgs/rating_icon.svg',
                            color: Color(0xffFFCC1B),
                          ),
                          half: SvgPicture.asset(
                            'assets/svgs/rating_icon.svg',
                            color: Color(0xffFFCC1B),
                          ),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate: (rnt) {
                          rating = rnt;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 6.5.h,
                    width: 100.w,
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Row(children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          no_call!.call();
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            'Skip',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xffFFCC1B),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(0xffFFCC1B),
                              ),
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      )),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          if (rating > 0.0) {
                            Navigator.of(context).pop();
                            done_call!.call(rating);
                          }
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                          decoration: BoxDecoration(
                              color: rating == 0.0
                                  ? Color(0xffFFCC1B).withOpacity(0.5)
                                  : Color(0xffFFCC1B),
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      )),
                    ]),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ]),
              ),
            ],
          )),
    ),
  );
}

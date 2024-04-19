import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => ViewDestinationMap(
                        dropoff_latLng: LatLng(
                            double.parse(
                                provider.viewRequestModel[index].dropLat ??
                                    '0.0'),
                            double.parse(
                                provider.viewRequestModel[index].dropLong ??
                                    '0.0')),
                        pickup_latLng: LatLng(
                            double.parse(
                                provider.viewRequestModel[index].pickUpLat ??
                                    '0.0'),
                            double.parse(
                                provider.viewRequestModel[index].pickUpLong ??
                                    '0.0')),
                      )));
            },
            child: Column(
              children: [
                Container(
                  //height: 13.h,
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
                                        provider.viewRequestModel[index]
                                                    .createdAt ==
                                                null
                                            ? ''
                                            : '${dt.format(DateTime.parse("${provider.viewRequestModel[index].createdAt}"))}',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                        'AED ${provider.viewRequestModel[index].amount}',
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
                                    )
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

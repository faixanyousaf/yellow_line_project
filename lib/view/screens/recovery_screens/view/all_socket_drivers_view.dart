import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../global_widgets/cupertino_alert_dialog.dart';
import '../model/socket_drivers_list_model.dart';
import '../view_model/add_request_provider.dart';

class AllSocketDriversView extends StatefulWidget {
  const AllSocketDriversView({Key? key}) : super(key: key);
  @override
  State<AllSocketDriversView> createState() => _AllSocketDriversViewState();
}

class _AllSocketDriversViewState extends State<AllSocketDriversView> {
  @override
  Widget build(BuildContext context) {
    final AddRequestProvider provider =
        Provider.of<AddRequestProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color(0xff181F30),
        appBar: AppBar(
          backgroundColor: Color(0xff181F30),
          elevation: 0,
          title: const Text(
            'Rides',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              show_cupertinoDialog(
                                  context: context,
                                  title: 'Cancel Request?',
                                  subtitle:
                                      'Are you sure you want to ignore all requests?',
                                  no_subtitle: 'No',
                                  yes_title: "Yes",
                                  on_done: () async {
                                    Navigator.of(context).pop();
                                  });
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'You can accept or decline offers',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 50), // Placeholder for spacing
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.newBidDriverModel?.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              color: Colors.black.withOpacity(0.1),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: 100.w,
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Profile Image
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage: NetworkImage(
                                              '${provider.newBidDriverModel?[index].profilePicture}'),
                                        ),
                                        SizedBox(width: 12.0),

                                        // Driver Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${provider.newBidDriverModel?[index].firstName} ${provider.newBidDriverModel?[index].lastName}',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // Text(
                                              //   driver['name'],
                                              //   style: TextStyle(
                                              //     color: Colors.white,
                                              //   ),
                                              // ),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors.yellow,
                                                      size: 16.0),
                                                  Text(
                                                    '0.0',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Price and ETA
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${provider.newBidDriverModel?[index].bidAmount} AED',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffFFD542),
                                              ),
                                            ),
                                            Text(
                                              'Plate Number : ${provider.newBidDriverModel?[index].plateNumber}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffFFD542),
                                              ),
                                            ),
                                            // Text(
                                            //   'Distance : ${provider.newBidDriverModel?[index].distance?.toStringAsFixed(1)}KM',
                                            //   style: TextStyle(
                                            //       fontSize: 12.0, color: Colors.grey),
                                            // ),
                                          ],
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
                                              show_cupertinoDialog(
                                                  context: context,
                                                  title: 'Cancel Request?',
                                                  subtitle:
                                                      'Are you sure you want to reject the offer?',
                                                  no_subtitle: 'No',
                                                  yes_title: "Yes",
                                                  on_done: () async {
                                                    // widget.reject_ride!.call(widget
                                                    //     .socketUsersListModel!
                                                    //     .data![index]
                                                    //     .id
                                                    //     .toString());
                                                    // Navigator.of(context).pop();
                                                  });
                                            },
                                            child: Container(
                                              height: 5.h,
                                              child: Center(
                                                child: Text(
                                                  'Reject',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              provider.stripe_payment(
                                                  context: context,
                                                  client_sectet: provider
                                                      .newBidDriverModel?[index]
                                                      .client_secret,
                                                  p_id: provider
                                                      .newBidDriverModel?[index]
                                                      .pid,
                                                  bid_id: provider
                                                      .newBidDriverModel?[index]
                                                      .bid_id);
                                            },
                                            child: Container(
                                              height: 5.h,
                                              child: Center(
                                                child: Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Color(0xffFFD542)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: LinearPercentIndicator(
                                            width: 85.w,
                                            animation: true,
                                            lineHeight: 1.5.h,
                                            onAnimationEnd: () {
                                              print('End animation');
                                            },
                                            animationDuration: 25000,
                                            percent: 1,
                                            barRadius: Radius.circular(30),
                                            progressColor: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (provider.load_payment_intent)
                Center(
                    child: InkWell(
                  onTap: () {
                    provider.load_payment_intent = false;
                    provider.update_state();
                  },
                  child: Container(
                    height: 15.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                        color: Color(0xffFFCC1B),
                        borderRadius: BorderRadius.circular(7)),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text('Wait for payment ...')
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}

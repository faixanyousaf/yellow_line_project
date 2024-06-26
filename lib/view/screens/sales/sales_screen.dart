import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../global_widgets/data_loading.dart';
import '../../../network_services/repository/user_repository/user_repo.dart';
import 'driver_chart.dart';
import 'clipper.dart';
import 'drop_down.dart';
import 'model/driver_request_model.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  DriverRequestModel? driverRequestModel;
  @override
  void initState() {
    get_user_info();
    super.initState();
  }

  List list_name = [
    'Total Revenue',
    'Total Requests',
    'Requests Completed',
    'Requests Active'
  ];
  String? start_date = '2024-05-01';
  String? end_date = '2024-05-30';
  List list_total = [];
  get_user_info() async {
    var result = await UserRepository.instance.business_all_requests(
        body: {"start_date": start_date, "end_date": end_date});
    driverRequestModel = DriverRequestModel.fromJson(result);
    list_total = [];
    list_total.add(driverRequestModel?.totalRevenue ?? 0);
    list_total.add(driverRequestModel?.totalRequests ?? 0);
    list_total.add(driverRequestModel?.requestsCompleted ?? 0);
    list_total.add(driverRequestModel?.requestsActive ?? 0);
    setState(() {});
    print('${driverRequestModel!.toJson()}');
    graph();
  }

  var chart_data;
  graph() async {
    print('call graph');
    if (current_chart == 'Yearly') {
      chart_data = await UserRepository.instance
          .business_all_requests_by_years(body: {"year": "2024"});
      setState(() {});
      print('chart_data.......${chart_data}');
    } else if (current_chart == 'Monthly') {
      chart_data = await UserRepository.instance
          .business_all_requests_by_month(body: {"year": "2024"});
      setState(() {});
      print('chart_data.......${chart_data}');
    } else {
      chart_data = await UserRepository.instance
          .business_all_requests_by_week(body: {"year": "2024", "month": "6"});
      setState(() {});
      print('chart_data.......${chart_data}');
    }
  }

  String current_chart = 'Yearly';
  List<String> all_chart_option = ['Yearly', 'Monthly', 'Weekly'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFCC1B),
      appBar: AppBar(
        backgroundColor: Color(0xff181F30),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)..pop();
          },
        ),
        title: Text(
          'Sales Report',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: driverRequestModel == null || chart_data == null
          ? DataLoading(
              child: SizedBox(),
              isLoading: true,
              use_opacity: false,
            )
          : Stack(
              children: [
                SizedBox(
                  child: CustomPaint(
                    size: Size(200.w, 50.h),
                    painter: RPSCustomPainter(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 4.h,
                                  width: 25.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFCC1B),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: CustomDropDown2(
                                      initial_value: '',
                                      drop_down_width: 30.w,
                                      list_items: all_chart_option,
                                      selected_index: (selected_index) {
                                        current_chart =
                                            all_chart_option[selected_index];
                                        graph();
                                        setState(() {});
                                      },
                                      prefix_icon_color: Colors.white,
                                      hint: '$current_chart',
                                      hint_font_size: 9.sp,
                                      hint_font_weight: true,
                                      prefix_icon: 'asset/svg/arrow.svg',
                                      drop_down_box_color: Color(0xffFFCC1B)
                                      //drop_down_width: 4.w,
                                      ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                            ),
                            Container(
                              child: Center(
                                  child: DriverChart(
                                chart: chart_data,
                                current_chart: current_chart,
                              )),
                              height: 30.h,
                              width: 100.w,
                            )
                          ],
                        ),
                      ),
                      // SliverToBoxAdapter(
                      //   child: SizedBox(
                      //     width: 100.w,
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //             child: Column(
                      //           children: [
                      //             InkWell(
                      //               onTap: () {
                      //                 showMaterialModalBottomSheet(
                      //                   context: context,
                      //                   backgroundColor: Colors.white,
                      //                   builder: (context) => Container(
                      //                     color: Colors.white,
                      //                     height: 50.h,
                      //                     width: MediaQuery.of(context).size.width,
                      //                     child: CustomCalender(
                      //                       function: (b) {
                      //                         print('date ...${b.toString()}');
                      //                         start_date =
                      //                             b.toString().split(' ')[0];
                      //                         get_user_info();
                      //                         setState(() {});
                      //                       },
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //               child: Container(
                      //                 height: 50,
                      //                 child: Center(child: Text('Start Date')),
                      //                 decoration:
                      //                     BoxDecoration(color: Color(0xffFFD542)),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 1.h,
                      //             ),
                      //             Center(
                      //                 child: Text(
                      //               '${start_date}',
                      //               style: TextStyle(color: Colors.white),
                      //             )),
                      //           ],
                      //         )),
                      //         SizedBox(
                      //           width: 15,
                      //         ),
                      //         Expanded(
                      //             child: Column(
                      //           children: [
                      //             InkWell(
                      //               onTap: () {
                      //                 showMaterialModalBottomSheet(
                      //                   context: context,
                      //                   backgroundColor: Colors.white,
                      //                   builder: (context) => Container(
                      //                     color: Colors.white,
                      //                     height: 50.h,
                      //                     width: MediaQuery.of(context).size.width,
                      //                     child: CustomCalender(
                      //                       function: (b) {
                      //                         print('date ...${b.toString()}');
                      //                         end_date = b.toString().split(' ')[0];
                      //                         get_user_info();
                      //                         setState(() {});
                      //                       },
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //               child: Container(
                      //                 height: 50,
                      //                 child: Center(child: Text('End Date')),
                      //                 decoration:
                      //                     BoxDecoration(color: Color(0xffFFD542)),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 1.h,
                      //             ),
                      //             Center(
                      //                 child: Text(
                      //               '${end_date}',
                      //               style: TextStyle(color: Colors.white),
                      //             )),
                      //           ],
                      //         )),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SliverToBoxAdapter(
                        child: Center(
                          child: Card(
                            child: SizedBox(
                              height: 15.h,
                              width: 25.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Revenue',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    '${list_total[0]} AED',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 15,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              'Requests Info',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            ListTile(
                              leading: Container(
                                child: Icon(
                                  Icons.access_time_outlined,
                                  size: 25,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellow),
                              ),
                              title: Text(
                                'Total Requests',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              trailing: Text(
                                '${list_total[1]}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            ListTile(
                              leading: Container(
                                child: Icon(
                                  Icons.check_circle,
                                  size: 25,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                              ),
                              title: Text(
                                'Requests Completed',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              trailing: Text(
                                '${list_total[2]}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            ListTile(
                              leading: Container(
                                child: Icon(
                                  Icons.change_circle,
                                  size: 25,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                              ),
                              title: Text(
                                'Requests Active',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              trailing: Text(
                                '${list_total[3]}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

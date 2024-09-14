import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../global_widgets/bottom_sheets_selection.dart';
import '../../../../global_widgets/custom_button.dart';
import '../../../global_widgets/data_loading.dart';
import 'Providers/add_vehicle_provider.dart';

class VehicleDetail extends StatefulWidget {
  const VehicleDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<VehicleDetail> createState() => _VehicleDetailState();
}

class _VehicleDetailState extends State<VehicleDetail> {
  @override
  void initState() {
    final AddVehicleProvider provider =
        Provider.of<AddVehicleProvider>(context, listen: false);
    provider.get_make().then((value) {});
    super.initState();
  }

  TextEditingController type_controller = TextEditingController();
  TextEditingController make_controller = TextEditingController();
  TextEditingController model_controller = TextEditingController();
  TextEditingController year_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AddVehicleProvider provider =
    Provider.of<AddVehicleProvider>(context);
    return DataLoading(
      isLoading: provider.loading,
      use_opacity: false,
      child: Scaffold(
        backgroundColor: Color(0xff181F30),
        appBar: AppBar(
          backgroundColor: Color(0xff181F30),
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 5.w,
              )),
          title: Text(
            'Add New Vehicles'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 5.w),
          //     child: Row(
          //       children: [
          //         Image(image: AssetImage('assets/bells.png')),
          //         SizedBox(
          //           width: 3.w,
          //         ),
          //         Container(
          //           height: 5.h,
          //           width: 5.w,
          //           decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.black,
          //               border: Border.all(width: 0.6, color: Colors.white)),
          //           child: Center(
          //             child: Icon(
          //               Icons.person,
          //               color: Colors.white,
          //               size: 3.w,
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Type (optional)'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: type_controller,
                              onChanged: (v) {
                                provider.vehicleName = v;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Choose vehicle type'.tr,
                                  hintStyle: TextStyle(
                                      color: Color(0xff181F30),
                                      fontSize: 10.sp)),
                            ),
                          ),
                          // InkWell(
                          //   child: Icon(Icons.keyboard_arrow_down, size: 22),
                          //   onTap: () {
                          //     listBottomSheet(
                          //         context: context,
                          //         add_new: () {},
                          //         selected_values: (v) {
                          //           provider.vehicleName = v[0];
                          //           type_controller.text = v[0];
                          //           provider.updateState();
                          //         },
                          //         hide_add_new: true,
                          //         pre_selected_all_values: [],
                          //         all_values: provider.vehiclesList);
                          //   },
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Make (optional)'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: make_controller,
                              onChanged: (v) {
                                provider.chooseCompanyName = v;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Choose company'.tr,
                                  hintStyle: TextStyle(
                                      color: Color(0xff181F30),
                                      fontSize: 10.sp)),
                            ),
                          ),
                          // InkWell(
                          //     onTap: () {
                          //       listBottomSheet(
                          //           context: context,
                          //           add_new: () {},
                          //           selected_values: (v) {
                          //             provider.modelName = null;
                          //             provider.chooseCompanyName = v[0];
                          //             make_controller.text = v[0];
                          //             provider.updateState();
                          //             provider.get_make_model();
                          //           },
                          //           hide_add_new: true,
                          //           pre_selected_all_values: [],
                          //           all_values: provider.car_make_list);
                          //     },
                          //     child: Icon(Icons.keyboard_arrow_down, size: 22))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Model (optional)'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: model_controller,
                              onChanged: (v) {
                                provider.modelName = v;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Choose vehicle model'.tr,
                                  hintStyle: TextStyle(
                                      color: Color(0xff181F30),
                                      fontSize: 10.sp)),
                            ),
                          ),
                          // InkWell(
                          //     onTap: () {
                          //       listBottomSheet(
                          //           context: context,
                          //           add_new: () {},
                          //           selected_values: (v) {
                          //             provider.modelName = v[0];
                          //             model_controller.text = v[0];
                          //             provider.updateState();
                          //           },
                          //           hide_add_new: true,
                          //           pre_selected_all_values: [],
                          //           all_values: provider.car_model_list);
                          //     },
                          //     child: Icon(Icons.keyboard_arrow_down, size: 22))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Year (optional)'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: year_controller,
                              onChanged: (v) {
                                provider.yearName = v;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Choose Year'.tr,
                                  hintStyle: TextStyle(
                                      color: Color(0xff181F30),
                                      fontSize: 10.sp)),
                            ),
                          ),
                          // InkWell(
                          //   child: Icon(Icons.keyboard_arrow_down, size: 22),
                          //   onTap: () {
                          //     listBottomSheet(
                          //         context: context,
                          //         add_new: () {},
                          //         selected_values: (v) {
                          //           provider.yearName = v[0];
                          //           year_controller.text = v[0];
                          //           provider.updateState();
                          //         },
                          //         hide_add_new: true,
                          //         pre_selected_all_values: [],
                          //         all_values: provider.chooseYearList);
                          //   },
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (provider.drivingLicense != null) {
                    print('object1');
                    await provider.add_vehicle_api();
                  } else {
                    print('object');
                    provider.isVisible = true;
                    setState(() {});
                  }
                },
                child: CustomButton(
                  buttonColor: Color(0xffFFD542),
                  borderColor: Color(0xffFFD542),
                  text: 'Add'.tr,
                  textColor: Color(0xff181F30),
                ),
              ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget typeContainer(String? title, String? text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(
            title!,
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text!,
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        )
      ],
    );
  }
}

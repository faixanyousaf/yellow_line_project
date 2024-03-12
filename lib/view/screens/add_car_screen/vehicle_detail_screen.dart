import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../global_widgets/custom_button.dart';
import '../../../../global_widgets/custom_drop_down.dart';
import '../../../global_widgets/data_loading.dart';
import 'Providers/add_vehicle_provider.dart';

class VehicleDetail extends StatefulWidget {
  const VehicleDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<VehicleDetail> createState() => _BusinessVehicleDetailState();
}

class _BusinessVehicleDetailState extends State<VehicleDetail> {
  @override
  void initState() {
    final AddVehicleProvider provider =
    Provider.of<AddVehicleProvider>(context, listen: false);
    provider.get_make().then((value) {});
    super.initState();
  }

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
            'Add New Vehicles',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Row(
                children: [
                  Image(image: AssetImage('assets/bells.png')),
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    height: 5.h,
                    width: 5.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        border: Border.all(width: 0.6, color: Colors.white)),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 3.w,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
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
                  'Type',
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
                            provider.vehicleName == null
                                ? 'Choose vehicle type'
                                : '${provider.vehicleName}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                          CustomDropdownButton2(
                            buttonDecoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            dropdownWidth: 100.w,
                            offset: Offset(0, -2.w),
                            icon: Icon(Icons.keyboard_arrow_down, size: 22),
                            hint: '',
                            dropdownItems: provider.vehiclesList!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text('$value',
                                    style: TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              print('$newValue');
                              provider.vehicleName = newValue;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (provider.isVisible == true && provider.vehicleName == null)
                SizedBox(
                  height: 1.h,
                ),
              if (provider.isVisible == true && provider.vehicleName == null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'No select vehicle type',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Make',
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
                            provider.chooseCompanyName == null
                                ? 'Choose company'
                                : '${provider.chooseCompanyName}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                          CustomDropdownButton2(
                            buttonDecoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            dropdownWidth: 100.w,
                            offset: Offset(0, -2.w),
                            icon: Icon(Icons.keyboard_arrow_down, size: 22),
                            hint: '',
                            dropdownItems: provider.car_make_list.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text('$value',
                                    style: TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              provider.modelName = null;
                              print('$newValue');
                              provider.chooseCompanyName = newValue;
                              provider.updateState();
                              provider.get_make_model();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (c) => CancelOrderPage(
                              //       comment: (v) async {
                              //         print('object =${v}');
                              //         DataProvider().cancel_order_api(
                              //             comment: v, order_id: widget.Id);
                              //         Navigator.of(context).pop(true);
                              //       },
                              //     ),
                              //     fullscreenDialog: true));
                              // showCancelOrderDialog(
                              //   (v) async {
                              //     print('object =${v}');
                              //     await DataProvider().cancel_order_api(
                              //         comment: v, order_id: widget.Id);
                              //     Navigator.of(context).pop(true);
                              //   },
                              // );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (provider.isVisible == true &&
                  provider.chooseCompanyName == null)
                SizedBox(
                  height: 1.h,
                ),
              if (provider.isVisible == true &&
                  provider.chooseCompanyName == null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'No select company',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Model',
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
                            provider.modelName == null
                                ? 'Choose vehicle model'
                                : '${provider.modelName}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                          CustomDropdownButton2(
                            buttonDecoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            dropdownWidth: 100.w,
                            offset: Offset(0, -2.w),
                            icon: Icon(Icons.keyboard_arrow_down, size: 22),
                            hint: '',
                            dropdownItems:
                                provider.car_model_list!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text('$value',
                                    style: TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              print('$newValue');
                              provider.modelName = newValue;
                              setState(() {});
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (c) => CancelOrderPage(
                              //       comment: (v) async {
                              //         print('object =${v}');
                              //         DataProvider().cancel_order_api(
                              //             comment: v, order_id: widget.Id);
                              //         Navigator.of(context).pop(true);
                              //       },
                              //     ),
                              //     fullscreenDialog: true));
                              // showCancelOrderDialog(
                              //   (v) async {
                              //     print('object =${v}');
                              //     await DataProvider().cancel_order_api(
                              //         comment: v, order_id: widget.Id);
                              //     Navigator.of(context).pop(true);
                              //   },
                              // );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (provider.isVisible == true && provider.modelName == null)
                SizedBox(
                  height: 1.h,
                ),
              if (provider.isVisible == true && provider.modelName == null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'No select vehicle model',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Year',
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
                            provider.yearName == null
                                ? 'Choose Year'
                                : '${provider.yearName}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                          CustomDropdownButton2(
                            buttonDecoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            dropdownWidth: 100.w,
                            icon: Icon(Icons.keyboard_arrow_down, size: 22),
                            hint: '',
                            dropdownItems:
                                provider.chooseYearList!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text('$value',
                                    style: TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              print('$newValue');
                              provider.yearName = newValue;
                              setState(() {});
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (c) => CancelOrderPage(
                              //       comment: (v) async {
                              //         print('object =${v}');
                              //         DataProvider().cancel_order_api(
                              //             comment: v, order_id: widget.Id);
                              //         Navigator.of(context).pop(true);
                              //       },
                              //     ),
                              //     fullscreenDialog: true));
                              // showCancelOrderDialog(
                              //   (v) async {
                              //     print('object =${v}');
                              //     await DataProvider().cancel_order_api(
                              //         comment: v, order_id: widget.Id);
                              //     Navigator.of(context).pop(true);
                              //   },
                              // );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (provider.isVisible == true && provider.yearName == null)
                SizedBox(
                  height: 1.h,
                ),
              if (provider.isVisible == true && provider.yearName == null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    'No select year',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              SizedBox(
                height: 2.h,
              ),
              // typeContainer('Type', 'Choose vehicle type'),
              // typeContainer('Make', 'Choose company'),
              // typeContainer('Model', 'Choose vehicle model'),
              // typeContainer('Year', 'Choose Year'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  'Registration card',
                  style: TextStyle(
                      color: provider.isVisible == true &&
                              provider.drivingLicense == null
                          ? Colors.red
                          : Colors.white,
                      fontSize: 10.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: InkWell(
                  onTap: () {
                    provider.uploadRegistrationFromGallery();
                  },
                  child: Container(
                    height: 12.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: provider.drivingLicense != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 6.h,
                                width: 12.w,
                                child: Image.file(
                                  File(provider.drivingLicense!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 5.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFD542),
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/svgs/arro.svg',
                                height: 2.3.h,
                              )),
                            ),
                    ),
                  ),
                ),
              ),
              // if(provider.isVisible == true && provider.drivingLicense == null)
              //   SizedBox(
              //     height: 1.h,
              //   ),
              // if(provider.isVisible == true && provider.drivingLicense == null)
              //   Padding(
              //     padding:  EdgeInsets.symmetric(horizontal: 6.w),
              //     child: Text('No select image',style: TextStyle(color: Colors.red,fontSize: 14),),
              //   ),
              SizedBox(
                height: 14.h,
              ),
              GestureDetector(
                onTap: () async {
                  if (provider.vehicleName != null &&
                      provider.chooseCompanyName != null &&
                      provider.yearName != null &&
                      provider.modelName != null &&
                      provider.drivingLicense != null) {
                    print('object1');
                    await provider.add_vehicle_api();
                  } else {
                    print('object');
                    provider.isVisible = true;
                    setState(() {});
                  }

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessVehicleAdded(),));
                },
                child: CustomButton(
                  buttonColor: Color(0xffFFD542),
                  borderColor: Color(0xffFFD542),
                  text: 'Add',
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

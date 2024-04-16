import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import '../../../../global_widgets/custom_button.dart';
import '../../../../global_widgets/custom_textfield.dart';
import '../../../global_widgets/bottom_sheets_selection.dart';
import '../../../helper/navigation/navigation_object.dart';
import '../../../helper/navigation/router_path.dart';
import 'Providers/add_vehicle_provider.dart';

class AddNewVehicleScreen extends StatefulWidget {
  const AddNewVehicleScreen({Key? key}) : super(key: key);

  @override
  State<AddNewVehicleScreen> createState() => _AddNewVehicleScreenState();
}

class _AddNewVehicleScreenState extends State<AddNewVehicleScreen> {
  @override
  void initState() {
    var provider = Provider.of<AddVehicleProvider>(context, listen: false);
    provider.get_cites().then((value) {
      load = false;
      provider.updateState();
    });
    super.initState();
  }

  @override
  void deactivate() {
    var provider = Provider.of<AddVehicleProvider>(context, listen: false);
    provider.loading = false;
    provider.codeController.text = '';
    provider.numberController.text = '';
    provider.isVisible = false;
    provider.index = 1;
    provider.vehicleName = null;
    provider.chooseCompanyName = null;
    provider.modelName = null;
    provider.yearName = null;
    provider.selectCityName = null;
    provider.drivingLicense = null;
    provider.RecoveryTypeId = '';
    super.deactivate();
  }

  bool load = true;

  @override
  Widget build(BuildContext context) {
    final AddVehicleProvider provider =
        Provider.of<AddVehicleProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DataLoading(
        isLoading: load,
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
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(right: 5.w),
            //     child: Row(
            //       children: [
            //         // Stack(
            //         //   children: [
            //         //     Image(image: AssetImage('assets/bells.png')),
            //         //     Positioned(
            //         //       top: 0,
            //         //       left: 1.5.w,
            //         //       child: Container(
            //         //         decoration: BoxDecoration(
            //         //             color: Colors.red,
            //         //             shape: BoxShape.circle
            //         //         ),
            //         //         child: Padding(
            //         //           padding: EdgeInsets.all(3),
            //         //           child: Text(
            //         //             '1',
            //         //             style: TextStyle(
            //         //                 color: Colors.white,
            //         //                 fontSize: 6.sp
            //         //             ),
            //         //           ),
            //         //         ),
            //         //       ),
            //         //     ),
            //         //   ],
            //         // ),
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
            child: Form(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  if (provider.cityModel.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Container(
                        height: 9.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: provider.codeController,
                                  textAlign: TextAlign.center,
                                  onChanged: (v) {
                                    provider.updateState();
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Code',
                                      hintStyle: TextStyle(
                                          color: Color(0xff181F30),
                                          fontSize: 13.sp)),
                                ),
                              ),
                              Container(
                                width: 0.3.w,
                                color: Color(0xffADADAD),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(provider
                                      .cityModel[provider.indexx].logoUrl!),
                                ),
                              ),
                              Container(
                                width: 0.3.w,
                                color: Color(0xffADADAD),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: provider.numberController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (v) {
                                    provider.updateState();
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Number',
                                      hintStyle: TextStyle(
                                          color: Color(0xff181F30),
                                          fontSize: 13.sp)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (provider.isVisible == true &&
                      (provider.numberController.text.isEmpty ||
                          provider.numberController.text.isEmpty))
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text(
                            'Please enter code and number',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Text(
                      'Select City',
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                      height: 9.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.55.h, horizontal: 1.w),
                        child: Center(
                          child: ListView.builder(
                            itemCount: provider.cityModel.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  provider.indexx = index;
                                  provider.selectCityName =
                                      provider.cityModel[index].name;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 29.w,
                                  height: 9.h,
                                  decoration: BoxDecoration(
                                    color: provider.indexx == index
                                        ? Color(0xffFFCC1B)
                                        : Color(0xffEDEDED),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${provider.cityModel[index].name}',
                                          style: TextStyle(
                                              color: Color(0xff181F30),
                                              fontSize: 9.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: InkWell(
                      onTap: () {
                        List<String> name = [];
                        for (var i in provider.recovery_type_model) {
                          name.add(i.typeName!);
                        }
                        listBottomSheet(
                            context: context,
                            disable_search: true,
                            add_new: () {},
                            selected_values: (v) {
                              provider.RecoveryTypeId = v[0];
                              provider.RecoveryTypeIndex =
                                  name.indexOf(provider.RecoveryTypeId!);
                              provider.updateState();
                            },
                            hide_add_new: true,
                            pre_selected_all_values: [],
                            all_values: name);
                      },
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
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/compan.svg',
                                      height: 1.5.h,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      provider.RecoveryTypeId!.isEmpty
                                          ? 'Select Recovery Type'
                                          : '${provider.RecoveryTypeId}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (provider.isVisible == true &&
                      provider.RecoveryTypeId!.isEmpty)
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text(
                            'Please select recovery type',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )),
                  SizedBox(
                    height: 3.h,
                  ),
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
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (provider.formKey.currentState!.validate() &&
                          provider.drivingLicense != null &&
                          provider.numberController.text.isNotEmpty &&
                          provider.numberController.text.isNotEmpty &&
                          provider.RecoveryTypeId!.isNotEmpty) {
                        navigationService.navigateTo(RouterPath.Vehicle_Detail);
                      } else {
                        print('object');
                        provider.isVisible = true;
                        setState(() {});
                      }
                    },
                    child: CustomButton(
                      textColor: Color(0xff181F30),
                      text: 'Next',
                      borderColor: Color(0xffFFCC1B),
                      buttonColor: Color(0xffFFCC1B),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

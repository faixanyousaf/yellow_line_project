import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/global_widgets/data_loading.dart';
import '../../../../global_widgets/custom_button.dart';
import '../../../../global_widgets/custom_textfield.dart';
import '../../../helper/navigation/navigation_object.dart';
import '../../../helper/navigation/router_path.dart';
import 'Providers/add_vehicle_provider.dart';

class AddNewVehicleScreen extends StatefulWidget {
  const AddNewVehicleScreen({Key? key}) : super(key: key);

  @override
  State<AddNewVehicleScreen> createState() =>
      _AddNewVehicleScreenState();
}

class _AddNewVehicleScreenState extends State<AddNewVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    final AddVehicleProvider provider =
    Provider.of<AddVehicleProvider>(context);
    return DataLoading(
      isLoading: provider.loading,
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
                  // Stack(
                  //   children: [
                  //     Image(image: AssetImage('assets/bells.png')),
                  //     Positioned(
                  //       top: 0,
                  //       left: 1.5.w,
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.red,
                  //             shape: BoxShape.circle
                  //         ),
                  //         child: Padding(
                  //           padding: EdgeInsets.all(3),
                  //           child: Text(
                  //             '1',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 6.sp
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
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
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(provider.codeController.text.isEmpty  ?
                              'Code':provider.codeController.text,overflow: TextOverflow.ellipsis,maxLines: 1,
                                style: TextStyle(
                                    color: Color(0xff181F30), fontSize: 16.sp),
                              ),
                            ),
                            Container(
                              width: 0.3.w,
                              color: Color(0xffADADAD),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                'City',
                                style: TextStyle(
                                    color: Color(0xff181F30), fontSize: 16.sp),
                              ),
                            ),
                            Container(
                              width: 0.3.w,
                              color: Color(0xffADADAD),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Text(provider.numberController.text.isEmpty  ?
                              'Number':'${provider.numberController.text}',
                                style: TextStyle(
                                    color: Color(0xff181F30), fontSize: 16.sp),
                              ),
                            ),
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
                      padding:
                      EdgeInsets.symmetric(vertical: 0.55.h, horizontal: 1.w),
                      child: Center(
                        child: ListView.builder(
                          itemCount: provider.cityList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                provider.indexx = index;
                                provider.selectCityName =
                                provider.cityList![index];
                                setState(() {});
                              },
                              child: Container(
                                width: 25.w,
                                height: 9.h,
                                decoration: BoxDecoration(
                                  color: provider.indexx == index
                                      ? Color(0xffFFCC1B)
                                      : Color(0xffEDEDED),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'أبو ظبي',
                                        style: TextStyle(
                                            color: Color(0xff181F30),
                                            fontSize: 9.sp),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        '${provider.cityList![index]}',
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
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Text(
                    'Code',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: CustommTextField(
                    hintText: 'Enter Code',
                    controller: provider.codeController,
                    onChange: (v){
                      provider.codeController.text = v;
                      provider.updateState();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter code';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Text(
                    'Plate Number',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: CustommTextField(
                    hintText: 'Enter Plate Number',
                    controller: provider.numberController,
                    onChange: (v){
                      provider.numberController.text = v;
                      provider.updateState();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter plate number';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                GestureDetector(
                  onTap: () async{
                    // if(provider.formKey.currentState!.validate()){
                    //   await provider.add_vehicle_api();
                    // }
                    if (provider.formKey.currentState!.validate()) {
                      navigationService
                          .navigateTo(RouterPath.Vehicle_Detail);
                    }

                  },
                  child: CustomButton(
                    textColor: Color(0xff181F30),
                    text: 'Next',
                    borderColor: Color(0xffFFCC1B),
                    buttonColor: Color(0xffFFCC1B),
                  ),
                )
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => DropOffScreen(),));
        //   },
        // ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_details.dart';
import '../../../../../global_widgets/custom_button.dart';
import '../../../global_widgets/data_loading.dart';
import '../../../helper/navigation/navigation_object.dart';
import '../../../helper/navigation/router_path.dart';

import 'Providers/view_list_vehicle_provider.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({Key? key}) : super(key: key);

  @override
  State<VehicleListScreen> createState() => _BusinessVehicleListScreenState();
}

class _BusinessVehicleListScreenState extends State<VehicleListScreen> {
  @override
  void initState() {
    var viewAllVehicleModel =
        Provider.of<ViewVehicleProvider>(context, listen: false);
    viewAllVehicleModel.view_vehicle_api(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewAllVehicleModel = Provider.of<ViewVehicleProvider>(context);
    return DataLoading(
      isLoading: viewAllVehicleModel.loading,
      use_opacity: false,
      child: Scaffold(
        backgroundColor: Color(0xff181F30),
        appBar: AppBar(
          backgroundColor: Color(0xff181F30),
          elevation: 0,
          //toolbarHeight: 9.h,
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
            'My Vehicles',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
          // actions: [
          //   // Padding(
          //   //   padding:  EdgeInsets.only(right: 5.w),
          //   //   child: Row(
          //   //     children: [
          //   //       Image(image: AssetImage('assets/bells.png')),
          //   //       SizedBox(width: 3.w,),
          //   //       Container(
          //   //         height: 4.h,
          //   //         width: 5.w,
          //   //         decoration: BoxDecoration(
          //   //             shape: BoxShape.circle,
          //   //             color: Colors.black,
          //   //             border: Border.all(width: 0.6,color: Colors.white)
          //   //         ),
          //   //         child: Center(
          //   //           child: Icon(Icons.person,color: Colors.white,size: 3.w,),
          //   //         ),
          //   //       )
          //   //     ],
          //   //   ),
          //   // ),
          //   Image(image: AssetImage('assets/bells.png')),
          //   SizedBox(
          //     width: 3.w,
          //   ),
          //   Padding(
          //     padding: EdgeInsets.only(right: 6.w),
          //     child: Container(
          //       height: 7.h,
          //       width: 5.w,
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.black,
          //           border: Border.all(width: 0.6, color: Colors.white)),
          //       child: Center(
          //         child: Icon(
          //           Icons.person,
          //           color: Colors.white,
          //           size: 3.w,
          //         ),
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: viewAllVehicleModel.result!.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => VehicleDetails(
                              vehicle: viewAllVehicleModel.result![index],
                            )));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Column(
                      children: [
                        if (viewAllVehicleModel.result != null)
                          Container(
                            height: 9.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '${viewAllVehicleModel.result![index].code}',
                                        style: TextStyle(
                                            color: Color(0xff181F30),
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image(
                                          image: NetworkImage(
                                            '${viewAllVehicleModel.result![index].cityLogo}',
                                          ),
                                          height: 7.5.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '${viewAllVehicleModel.result![index].plateNumber}',
                                        style: TextStyle(
                                            color: Color(0xff181F30),
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )),
              GestureDetector(
                onTap: () {
                  navigationService
                      .navigateTo(RouterPath.Add_New_Vehicle_Screen)!
                      .then((value) {
                    viewAllVehicleModel.loading = true;
                    viewAllVehicleModel.updateState();
                    viewAllVehicleModel.result = [];
                    viewAllVehicleModel.view_vehicle_api(context);
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessAddVehicleScreen(),));
                },
                child: CustomButton(
                  buttonColor: Color(0xffFFD542),
                  borderColor: Color(0xffFFD542),
                  text: 'Add New Vehicle',
                  textColor: Color(0xff181F30),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewVehicleScreen(),));
        //   },
        // ),
      ),
    );
  }
}

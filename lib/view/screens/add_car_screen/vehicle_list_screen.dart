import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_details.dart';
import '../../../../../global_widgets/custom_button.dart';
import '../../../global_widgets/data_loading.dart';
import '../../../global_widgets/refresh_controller.dart';
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

  var refreshController = RefreshController(initialRefresh: false);
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
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Expanded(
                  child: RefreshControllerGlobal(
                controller: refreshController,
                onRefresh: () async {
                  await viewAllVehicleModel.view_vehicle_api(context);
                  ;
                  refreshController.refreshCompleted();
                },
                onLoad: () async {
                  refreshController.loadComplete();
                },
                child: viewAllVehicleModel.result!.length == 0 &&
                        !viewAllVehicleModel.loading
                    ? Column(
                        children: [
                          Container(
                            height: 15.h,
                            width: 30.w,
                            child: Image.asset('assets/vehicle_car.png'),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2)),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            'No Vehicles Added',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Please click the below button',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            'to add a Vehicle',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      )
                    : ListView.builder(
                        itemCount: viewAllVehicleModel.result!.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => VehicleDetails(
                                      vehicle:
                                          viewAllVehicleModel.result![index],
                                    )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.h),
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
                                                padding:
                                                    const EdgeInsets.all(16.0),
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

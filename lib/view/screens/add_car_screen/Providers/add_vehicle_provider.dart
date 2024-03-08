import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yellowline/view/screens/add_car_screen/Network%20Call/network_call.dart';

import '../../../../../helper/navigation/navigation_object.dart';
import '../../../../../helper/navigation/router_path.dart';


class AddVehicleProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  DataProvider dataProvider = DataProvider();
  bool loading = false;
  bool? isVisible = false;
  int index = 1;
  String? vehicleName;
  String? chooseCompanyName;
  String? modelName;
  String? yearName;
  String? selectCityName;

  List<String>? cityList = [
    'Dubai',
    'Abu Dhabi',
  ];
  List<String>? vehiclesList = [
    'Taxi',
    'Bus',
    'Skateboard',
    'Bicycle',
    'Scooter',
    'Forklift',
  ];
  List<String>? companyList = [
    'Hyundai',
    'Toyota',
    'MG',
    'Honda Atlas',
    'Changan',
    'PAK Suzuki',
  ];
  List<String>? chooseYearList = [
    '1938',
    '1944',
    '1943',
    '2010',
    '2011',
    '2012',
  ];

  File? drivingLicense;

  final drivingLicensePicker = ImagePicker();


  Future uploadRegistrationFromGallery() async {
    final pickedFile = await drivingLicensePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      drivingLicense = File(pickedFile.path);
    }
    updateState();
  }



  TextEditingController codeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  int indexx = 0;


  add_vehicle_api() async{
    // if (formKey.currentState!.validate()){
    //   // loading = true;
    //   // updateState();
    //   // var result = await dataProvider.add_new_vehicle_api(
    //   //     map: {
    //   //       'city' : '${selectCityName}',
    //   //       'code' : '${codeController.text}',
    //   //       'plate_number' : '${numberController.text}',
    //   //       'type' : '${vehicleName}',
    //   //       'make' : '${chooseCompanyName}',
    //   //       'model' : '${modelName}',
    //   //       'year' : '${yearName}',
    //   //       'registration_card' : await dio.MultipartFile.fromFile(
    //   //           drivingLicense!.path),
    //   //       'city_logo' : await dio.MultipartFile.fromFile(
    //   //           drivingLicense!.path),
    //   //       'company_id' : '82',
    //   //     }
    //   // );
    //   // print('object of all data ${result}');
    //   // loading = false;
    //   // updateState();
    //   // navigationService.navigateTo(RouterPath.Business_Vehicle_Added);
    //   // print('object of all data ${result}');
    // }
    loading = true;
    updateState();
    var result = await dataProvider.add_new_vehicle_api(
        map: {
          'city' : '${selectCityName}',
          'code' : '${codeController.text}',
          'plate_number' : '${numberController.text}',
          'type' : '${vehicleName}',
          'make' : '${chooseCompanyName}',
          'model' : '${modelName}',
          'year' : '${yearName}',
          'registration_card' : await dio.MultipartFile.fromFile(
              drivingLicense!.path),
          'city_logo' : await dio.MultipartFile.fromFile(
              drivingLicense!.path),
          'company_id' : '86',
        }
    );
    print('object of all data ${result}');
    loading = false;
    updateState();
    navigationService.navigateTo(RouterPath.Vehicle_Added_Screen);
    print('object of all data ${result}');
  }

  updateState() {
    notifyListeners();
  }
}

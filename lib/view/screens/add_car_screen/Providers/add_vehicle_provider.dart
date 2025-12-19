import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yellowline/view/screens/add_car_screen/Network%20Call/network_call.dart';

import '../../../../../helper/navigation/navigation_object.dart';
import '../../../../../helper/navigation/router_path.dart';
import '../../../../helper/shared_prefs.dart';
import '../../../../network_services/repository/user_repository/user_repo.dart';
import '../Models/car_model.dart';
import '../Models/city_model.dart';
import '../Models/recovery_type_model.dart';

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

  List<CityModel> cityModel = [];
  List<RecoveryTypeModel> recovery_type_model = [];

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
  List<String> car_make_list = [];
  List<String>? car_model_list = [];

  List<String>? chooseYearList = [
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
    '2011',
    '2010',
    '2009',
    '2008',
    '2007',
    '2006',
    '2005',
    '2004',
    '2003',
    '2002',
    '2001',
    '2000',
    '1999',
    '1998',
    '1997',
    '1996',
  ];

  File? drivingLicense;
  String? RecoveryTypeId = '';
  int? RecoveryTypeIndex;
  final drivingLicensePicker = ImagePicker();

  Future uploadRegistrationFromGallery(File file) async {
    drivingLicense=file;
    updateState();
  }

  TextEditingController codeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  int indexx = 0;

  add_vehicle_api() async {
    SharedPrefs sf = SharedPrefs();
    var id = await sf.getid();
    loading = true;
    updateState();
    print('${{
      'account_type': '2',
      'city': '${selectCityName}',
      'code': '${codeController.text}',
      'plate_number': '${numberController.text}',
      'type': '${vehicleName}',
      'make': '${chooseCompanyName}',
      'model': '${modelName}',
      'year': '${yearName}',
      'registration_card':
      await dio.MultipartFile.fromFile(drivingLicense!.path),
      'city_logo': cityModel[indexx].logoUrl,
      'account_id': '$id',
      'recovery_type': recovery_type_model[RecoveryTypeIndex!].id
    }}');
    var result = await dataProvider.add_new_vehicle_api(map: {
      'account_type': '2',
      'city': '${selectCityName}',
      'code': '${codeController.text}',
      'plate_number': '${numberController.text}',
      'type': '${vehicleName}',
      'make': '${chooseCompanyName}',
      'model': '${modelName}',
      'year': '${yearName}',
      'registration_card':
          await dio.MultipartFile.fromFile(drivingLicense!.path),
      'city_logo': cityModel[indexx].logoUrl,
      'account_id': '$id',
      'recovery_type': recovery_type_model[RecoveryTypeIndex!].id
    });
    print('object of all data ${result}');
    loading = false;
    updateState();
    navigationService.navigateTo(RouterPath.Vehicle_Added_Screen);
    print('object of all data ${result}');
  }

  updateState() {
    notifyListeners();
  }

  Future get_make() async {
    car_make_list = [];
    loading = true;
    updateState();
    try{
      List<CarModel>? carModel = await dataProvider.get_make();
      for (var i in carModel!) {
        car_make_list.add(i.make!);
      }
      loading = false;
      updateState();
    }catch (e){
      loading = false;
      updateState();
    }
  }

  Future get_make_model() async {
    car_model_list = [];
    loading = true;
    updateState();
    List<CarModel>? carModel =
        await dataProvider.get_make_model(chooseCompanyName);
    for (var i in carModel!) {
      car_model_list!.add(i.model!);
    }
    loading = false;
    updateState();
  }

  Future get_cites() async {
    var result = await UserRepository.instance.get_cites();
    for (var i in result) {
      cityModel.add(CityModel.fromJson(i));
    }
    updateState();
    var recovery = await UserRepository.instance.get_recovery_type();
    for (var i in recovery) {
      recovery_type_model.add(RecoveryTypeModel.fromJson(i));
    }
  }
}

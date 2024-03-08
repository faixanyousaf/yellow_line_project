import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import '../../../../helper/shared_prefs.dart';
import '../Models/view_list_vehicle_model.dart';
dynamic baseUrl = 'http://yellowline.codeels.pro/';
const addNewDriverUrl = 'driver/create';
const viewNewDriverUrl = 'driver/list/';
const viewNewVehicleUrl = 'vehicle/add';

class DataProvider {

  Future add_new_vehicle_api({required Map<String, dynamic> map}) async {
    print('objectofal ${map}');
    SharedPrefs sf = SharedPrefs();
    var tocken = await sf.getToken();
    final response = await dio.Dio().post('$baseUrl$viewNewVehicleUrl',
        data: dio.FormData.fromMap(map),
        options: dio.Options(headers: {
          'Authorization':
          '${tocken}',
        }));
    var data = response.data;
    print( ' the response is =${data}');
    return data;
  }

  Future viewVehicles({String? Id}) async {
    SharedPrefs sf = SharedPrefs();
    var tocken = await sf.getToken();
    List<ViewAllVehicle>? vehicleModel = [];
    final response =
    await dio.Dio().get('http://yellowline.codeels.pro/vehicle/user/list/86',
        options: dio.Options(headers: {
          'Authorization':
          '${tocken}'
        }));
    print("status code is ${response.data}");
    List data = response.data;
    for (var i in data) {
      vehicleModel.add(ViewAllVehicle.fromJson(i));
    }
    return vehicleModel;
  }
}
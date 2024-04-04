import 'package:dio/dio.dart' as dio;
import '../../../../helper/shared_prefs.dart';
import '../Models/car_model.dart';

dynamic baseUrl = 'https://yellowline.codeels.pro/';
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
          'Authorization': '${tocken}',
        }));
    var data = response.data;
    print(' the response is =${data}');
    return data;
  }

  Future get_make() async {
    List<CarModel>? carModel = [];
    final response = await dio.Dio().get(
        'https://api.api-ninjas.com/v1/cars?year=2023&limit=100',
        options: dio.Options(headers: {
          'X-Api-Key': '3qjKnlH+K2PvEiNXbyhDng==UCwUS1lgr9hrMUo3'
        }));
    print("status code is ${response.data}");
    List data = response.data;
    for (var i in data) {
      carModel.add(CarModel.fromJson(i));
    }
    return carModel;
  }

  Future get_make_model(name) async {
    List<CarModel>? carModel = [];
    final response = await dio.Dio().get(
        'https://api.api-ninjas.com/v1/cars?year=2023&limit=100&make=$name',
        options: dio.Options(headers: {
          'X-Api-Key': '3qjKnlH+K2PvEiNXbyhDng==UCwUS1lgr9hrMUo3'
        }));
    print("status code is ${response.data}");
    List data = response.data;
    for (var i in data) {
      carModel.add(CarModel.fromJson(i));
    }
    return carModel;
  }
}

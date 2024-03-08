import 'package:flutter/cupertino.dart';
import 'package:yellowline/view/screens/add_car_screen/Network%20Call/network_call.dart';
import '../../../../helper/shared_prefs.dart';
import '../Models/view_list_vehicle_model.dart';

class ViewVehicleProvider extends ChangeNotifier {
  DataProvider dataProvider = DataProvider();
  // SharedPrefs sf = SharedPrefs();
  // var tocken =  sf.getToken();
  bool loading = false;
  List<ViewAllVehicle>? result;

  view_vehicle_api(BuildContext? context) async {
    result=[];
    loading = true;
    updateState();
    result = await dataProvider.viewVehicles(Id: '86');
    print('object of all data ${result}');
     loading = false;
    updateState();
    print('object of all data ${result}');
  }

  updateState() {
    notifyListeners();
  }
}

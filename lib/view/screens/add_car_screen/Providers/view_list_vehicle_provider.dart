import 'package:flutter/cupertino.dart';
import 'package:yellowline/view/screens/add_car_screen/Network%20Call/network_call.dart';
import '../../../../helper/shared_prefs.dart';
import '../../../../network_services/repository/user_repository/user_repo.dart';
import '../Models/view_list_vehicle_model.dart';

class ViewVehicleProvider extends ChangeNotifier {
  DataProvider dataProvider = DataProvider();
  bool loading = false;
  List<ViewAllVehicle>? result=[];

  view_vehicle_api(BuildContext? context) async {
    SharedPrefs sf = SharedPrefs();
    var id = await sf.getid();
    result = [];
    loading = true;
    updateState();

    List data = await UserRepository.instance.get_vehicle(id: id);
    for (var i in data) {
      result!.add(ViewAllVehicle.fromJson(i));
    }
    // result = await dataProvider.viewVehicles(Id: id);
    print('object of all data ${result}');
    loading = false;
    updateState();
    print('object of all data ${result}');
  }

  updateState() {
    notifyListeners();
  }
}

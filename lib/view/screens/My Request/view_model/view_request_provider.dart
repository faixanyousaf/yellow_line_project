import 'package:flutter/cupertino.dart';

import '../../../../helper/shared_prefs.dart';
import '../../../../network_services/repository/user_repository/user_repo.dart';
import '../model/view_request_model.dart';

class ViewRequestProvider extends ChangeNotifier {
  List<ViewRequestModel> viewRequestModel = [];
  bool loading = false;

  get_request_data({required int status}) async {
    try {
      viewRequestModel = [];
      loading = true;
      update_state();
      SharedPrefs sf = SharedPrefs();
      var id = await sf.getid();
      List data = await UserRepository.instance
          .get_view_request(body: {"user_id": id, "status": status});
      print('get_view_request............${data}');
      for (var i in data) {
        viewRequestModel.add(ViewRequestModel.fromJson(i));
      }
      print('objviewRequestModelect ${viewRequestModel.length}');
      loading = false;
      update_state();
    } catch (e) {
      print('exceptionn..$e');
      loading = false;
      update_state();
    }
  }

  update_state() {
    notifyListeners();
  }
}

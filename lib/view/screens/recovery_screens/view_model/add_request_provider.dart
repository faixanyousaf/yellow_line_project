import 'package:flutter/cupertino.dart';

import '../../../../helper/navigation/navigation_object.dart';
import '../../../../helper/navigation/router_path.dart';
import '../../../../helper/shared_prefs.dart';
import '../../../../helper/stripe_payment_methods.dart';
import '../../../../network_services/repository/user_repository/user_repo.dart';
import '../model/UpdatePaymentRequest.dart';
import '../model/charege_user_request_model.dart';
import '../model/charege_user_responce_model.dart';
import '../model/request_recovery_model.dart';
import '../model/responce_fare_model.dart';

class AddRequestProvider extends ChangeNotifier {
  bool loading = false;
  Request_Recovery_Model request_model = Request_Recovery_Model();
  ChargeUserResponceModel? chargeUserResponceModel;
  Responce_fare_model? responce_fare_model;
  List<String> recovery_type_list = ['Normal', 'Sports', 'Heavy'];
  String selected_recovery_type = 'Normal';
  String? pickup_name = '';
  String? dropoff_name = '';

  calculate_fare() async {
    loading = true;
    update_state();
    print('${request_model.toJson()}');
    Map<String, dynamic> body = {
      "lat1": "33.7300625",
      "long1": "73.0769375",
      "lat2": "33.72034609611864",
      "long2": "73.05950383718141",
      "recoveryType": 3
    };
    try {
      var data = await UserRepository.instance
          .calculate_fare(body: request_model.toJson());
      print('calculate_fare ...... $data');
      responce_fare_model =
          Responce_fare_model.fromJson(data as Map<String, dynamic>);
      loading = false;
      update_state();
    } catch (e) {
      print('Exception ... $e');
      loading = false;
      update_state();
    }
  }

  charge_user(BuildContext context) async {
    try {
      print('call');
      loading = true;
      update_state();
      SharedPrefs sf = SharedPrefs();
      var id = await sf.getid();
      ChargeUserRequestModel chargeUserRequestModel = ChargeUserRequestModel(
          amount: responce_fare_model!.totalCharges!.toInt(),
          userId: id.toString(),
          plateNumber: 1097,
          dropLat: request_model.lat2,
          dropLong: request_model.long2,
          pickUpLat: request_model.lat1,
          dropName: pickup_name,
          pickupName: dropoff_name,
          pickUpLong: request_model.long1);
      print('step1');
      var data = await UserRepository.instance
          .charge_user(body: chargeUserRequestModel.toJson());
      print('step2');
      chargeUserResponceModel = ChargeUserResponceModel.fromJson(data);
      print('step3');
      loading = false;
      update_state();
      stripe_payment(context);
    } catch (e) {
      print('$e');
      loading = false;
      update_state();
    }
  }

  stripe_payment(BuildContext context) {
    makePayment(
        transactionID: (v) {
          UpdatePaymentRequest request = UpdatePaymentRequest(
              paid: 1, requestId: chargeUserResponceModel!.data!.id);
          UserRepository.instance.update_payment_status(body: request.toJson());
          navigationService
              .navigatePushReplace(RouterPath.complete_request_screen);
        },
        context: context,
        client_secret: chargeUserResponceModel!.clientSecret!,
        payment_intent_id: chargeUserResponceModel!.piId!);
  }

  update_state() {
    notifyListeners();
  }
}

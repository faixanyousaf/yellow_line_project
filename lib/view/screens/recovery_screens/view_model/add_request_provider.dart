import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:yellowline/global_widgets/asset_to_unit8list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/cupertino.dart';
import 'package:yellowline/view/screens/recovery_screens/model/socket_drivers_list_model.dart';
import '../../../../core/network/routes/base_url.dart';
import '../../../../helper/navigation/navigation_object.dart';
import '../../../../helper/navigation/router_path.dart';
import '../../../../helper/shared_prefs.dart';
import '../../../../helper/stripe_payment_methods.dart';
import '../../../../network_services/repository/user_repository/user_repo.dart';
import '../model/UpdatePaymentRequest.dart';
import '../model/all_available_drivers.dart';
import '../model/charege_user_request_model.dart';
import '../model/charege_user_responce_model.dart';
import '../model/my_pending_request_model.dart';
import '../model/new_bid_driver_model.dart';
import '../model/recovery_type_model.dart';
import '../model/request_recovery_model.dart';
import '../model/responce_fare_model.dart';
import 'package:geolocator/geolocator.dart';
import '../model/total_fare_model.dart';
import '../view/all_socket_drivers_view.dart';
import '../view/my_pending_request_screen.dart';

class AddRequestProvider extends ChangeNotifier {
  bool loading = false;
  Request_Recovery_Model request_model = Request_Recovery_Model();
  ChargeUserResponceModel? chargeUserResponceModel;
  Responce_fare_model? responce_fare_model;
  String selected_recovery_type = 'Normal';
  String? pickup_name = '';
  String? dropoff_name = '';
  AllAvailableDrivers? allAvailableDrivers;
  TotalFareModel? totalFareModel;
  List<NewBidDriverModel>? newBidDriverModel = [];
  var markersList = <MarkerId, Marker>{};
  bool load_payment_intent = false;
  bool load_find_driver = false;

  calculate_fare() async {
    loading = true;
    update_state();
    print('request_model ....${request_model.toJson()}');
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
      int index_recovery = recovery_type_model
          .indexWhere((element) => element.typeName == selected_recovery_type);
      ChargeUserRequestModel chargeUserRequestModel = ChargeUserRequestModel(
          amount: responce_fare_model!.totalCharges!.toInt().toString(),
          userId: id.toString(),
          plateNumber: 1097.toString(),
          dropLat: request_model.lat2,
          dropLong: request_model.long2,
          pickUpLat: request_model.lat1,
          dropName: pickup_name,
          pickupName: dropoff_name,
          recovery_type: recovery_type_model[index_recovery].id.toString(),
          pickUpLong: request_model.long1);
      print('step1');
      var data = await UserRepository.instance
          .charge_user(body: chargeUserRequestModel.toJson());
      print('step2 ${data}');
      chargeUserResponceModel = ChargeUserResponceModel.fromJson(data);
      print('step3');
      loading = false;
      update_state();
      // stripe_payment(context);
    } catch (e) {
      print('$e');
      loading = false;
      update_state();
    }
  }

  stripe_payment(
      {BuildContext? context, var p_id, var client_sectet, var bid_id}) {
    makePayment(
        transactionID: (v) {
          // UpdatePaymentRequest request = UpdatePaymentRequest(
          //     paid: 1, requestId: chargeUserResponceModel!.data!.id);
          // UserRepository.instance.update_payment_status(body: request.toJson());
          // navigationService
          //     .navigatePushReplace(RouterPath.complete_request_screen);

          accept_offer(
              context: context, data: {"bid_id": '${bid_id}', 'trx_id': '$v'});
        },
        context: context!,
        client_secret: client_sectet,
        payment_intent_id: p_id);
  }

  update_state() {
    notifyListeners();
  }

  List<RecoveryTypeModel> recovery_type_model = [];
  get_recovery_type() async {
    var recovery = await UserRepository.instance.get_recovery_type();
    for (var i in recovery) {
      recovery_type_model.add(RecoveryTypeModel.fromJson(i));
    }
    update_state();
  }

  IO.Socket? socket;
  Timer? timer;
  var user_id;
  initialize_socket(BuildContext context) async {
    print('Call socket.....');
    SharedPrefs sf = SharedPrefs();
    user_id = await sf.getid();
    try {
      socket = IO.io(
          '${socket_url}?userId=${user_id}',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      socket!.connect();
      socket!.onConnect((_) {
        print('connect socket');
        drivers_list(context);
        update_location(context);
        find_nearby_drivers(context);
        total_fare(context);
        accept_ride_request(context);
        reject_ride_request(context);
        bid_offers(context);
        ride_completed(context);
        pid_created();
      });
    } catch (e) {
      print("socket exception is ..... ${e.toString()}");
    }
  }

  find_nearby_drivers(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    socket!.emit('findNearByDrivers', {
      "pick_up_lat": "${position.latitude}",
      "pick_up_long": "${position.longitude}",
      "driver_id": user_id
    });
    print('Driver updated');
  }

  drivers_list(BuildContext context) {
    socket!.on('driversList', (value) {
      print('driversList.......${value}');
      allAvailableDrivers = AllAvailableDrivers.fromJson(value);
      update_state();
      allAvailableDrivers!.data!.forEach((v) async {
        final Uint8List markerIcon =
            await getBytesFromAsset('assets/driver_icon.png', 100);
        final markerId = MarkerId('${v.id}');
        print('lat......${v.lat.toString()}');
        final marker = Marker(
          icon: BitmapDescriptor.fromBytes(markerIcon),
          markerId: MarkerId(UniqueKey().toString()),
          position: LatLng(
              double.parse(v.lat.toString()), double.parse(v.lng.toString())),
          infoWindow: InfoWindow(title: v.name),
        );
        final iceGiants = {markerId: marker};
        markersList.addEntries(iceGiants.entries);
        update_state();
      });
      update_state();
      // SocketDriversListModel socketUsersListModel =
      //     SocketDriversListModel.fromJson(value);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (c) => AllSocketDriversView(
      //           socketUsersListModel: socketUsersListModel,
      //           accept_ride: (v) {
      //             print('${v}');
      //             if (v['is_counter_offer'] == true) {
      //               accept_ride_request(
      //                   {'request_id': 2, 'driver_id': user_id});
      //             } else {
      //               // bid_Against_request({
      //               //   'request_id': 2,
      //               //   'driver_id': user_id,
      //               //   'bid_amount': v['counter_offer']
      //               // });
      //             }
      //           },
      //           reject_ride: (v) {
      //             reject_ride_request({'request_id': v, 'driver_id': user_id});
      //           },
      //         )));
    });
  }

  find_driver_request({Map<String, dynamic>? data}) {
    data!.addAll({'user_id': '${user_id}'});
    print('find_driver_request...${data}');
    socket!.emit('charge', data);
    load_find_driver = true;
    update_state();
  }

  create_payment_intent({Map<String, dynamic>? data}) {
    print('create_payment_intent ...${data}');
    socket!.emit('createPyamentIntent', data);
    load_payment_intent = true;
    update_state();
  }

  pid_created() {
    socket!.on("pidCreated", (data) {
      print('pidCreated... $data');
      load_payment_intent = false;
      update_state();
    });
  }

  caculate_fare({Map<String, dynamic>? data}) {
    data!.addAll({'user_id': '${user_id}'});
    socket!.emit('calculateFare', data);
  }

  ride_completed(BuildContext context) {
    socket!.on("rideCompleted", (data) {
      print('ride completed ...${data}');
      navigationService.navigatePushReplace(RouterPath.complete_request_screen);
    });
  }

  bid_offers(BuildContext context) {
    socket!.on("newBid", (data) {
      print('new bid.... ${data}');
      if (newBidDriverModel!.isEmpty) {
        navigationService.navigateTo(RouterPath.AllSocketDriversView);
      }
      List list = jsonDecode(data);
      list.forEach((v) {
        if (newBidDriverModel!.indexWhere((b) => b.driver == v['driver']) ==
            -1) {
          NewBidDriverModel BidModel = NewBidDriverModel.fromJson(v);
          BidModel.active = true;
          newBidDriverModel!.add(BidModel);
        }
      });
      update_state();
    });
  }

  accept_offer({Map<String, dynamic>? data, BuildContext? context}) {
    print('acceptOffer.....$data');
    socket!.emit('acceptOffer', data);
    var snackBar = SnackBar(
      content: Text(
        'Offer Accepted',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  reject_offer({Map<String, dynamic>? data, var index}) {
    socket!.emit('rejectOffer', data);
    newBidDriverModel!.removeAt(index);
    update_state();
  }

  total_fare(BuildContext context) {
    socket!.on("fareCalculation", (data) {
      print('total fare ${data}');
      totalFareModel = TotalFareModel.fromJson(data);
      update_state();
    });
  }

  accept_ride_request(BuildContext context) {
    socket!.on("rideAccepted", (data) {
      load_find_driver = false;
      update_state();
      print('rideAccepted ${data}');
      print('push to MyPendingRequestMapView');
      var snackBar = SnackBar(
        content: Text(
          'Ride Accepted',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    });
  }

  cancel_ride_request(BuildContext context, Map<String, dynamic>? data) {
    print('cancel_ride ...${data}');
    socket!.emit('cancelRideByUser', data);
  }

  reject_ride_request(BuildContext context) {
    socket!.on("rideRejected", (data) {
      print('rideRejected ${data}');
    });
  }

  update_location(BuildContext context) async {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      bool chkLocation = await _handleLocationPermission(context);
      if (chkLocation == true) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print('location update ${position.latitude} ${position.longitude}');
        socket!.emit('updateUserLocation', {
          'lat': "${position.latitude}",
          'long': "${position.longitude}",
          'user_id': user_id
        });
      }
    });
  }

  close_all_function() {
    print('call dispose');
    socket!.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }
}

Future<bool> _handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Location services are disabled. Please enable the services'.tr)));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied'.tr)));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.'
                .tr)));
    return false;
  }
  return true;
}

import 'package:flutter/material.dart';
import '../helper/navigation/navigation_object.dart';

show_toast({required String msg}) {
  ScaffoldMessenger.of(navigationService.navigatorKey.currentState!.context)
      .showSnackBar(SnackBar(
    content: Text(
      '$msg',
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
  ));
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget statusBarStyle({Widget? child}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: Platform.isAndroid
        ? SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark)
        : SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light),
    child: child!,
  );
}

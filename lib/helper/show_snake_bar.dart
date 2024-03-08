import 'package:flutter/material.dart';
import 'navigation/locator.dart';
import 'navigation/navigation_service.dart';

class ShowSnackBar {
  static showSnackBar({required String msg}) {
    ScaffoldMessenger.of(
      locator<NavigationService>().navigatorKey.currentContext!,
    ).showSnackBar(SnackBar(content: Text(msg)));
  }
}

import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? navigatePushReplace(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String til, String routName) {
    try {
      var a = navigatorKey.currentState!.pushNamedAndRemoveUntil(
        til,
        ModalRoute.withName(routName),
      );
      return a;
    } catch (e) {
      throw e;
    }
  }

  void popUntil(String routName) {
    try {
      var a = navigatorKey.currentState!.popUntil(
        ModalRoute.withName(routName),
      );
      return a;
    } catch (e) {
      print("error pop: ${e.toString()} ");
      throw e;
    }
  }

  goBack({dynamic value}) {
    if (value != null) {
      return navigatorKey.currentState!.pop(value);
    } else {
      return navigatorKey.currentState!.pop();
    }
  }

  maybeGoBack() {
    return navigatorKey.currentState!.maybePop();
  }

  goToRoot() {
    return navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  bool canGoBack() {
    return navigatorKey.currentState!.canPop();
  }

  pushAndRemoveUntil(Widget widget) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => widget),
      ModalRoute.withName('/'),
    );
  }
}

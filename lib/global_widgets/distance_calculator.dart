import 'dart:math';

String calculateDistance(
    {required lat1, required lon1, required lat2, required lon2}) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  double total_distance = 12742 * asin(sqrt(a));
  return total_distance.toStringAsFixed(1);
}

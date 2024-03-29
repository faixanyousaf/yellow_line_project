import 'base_url.dart';

class ApiRoutes {
  // static String picBaseURL = 'https://cdn.sarya.app/itinerary/';
  // static String avatarURL = 'https://cdn.sarya.app/avatars/';

  ///users authentication
  static String signup = '${base_URL}user/signup';
  static String socail_signup = '${base_URL}user/socialsignup';
  static String login = '${base_URL}auth/users/customer';
  static String cities = '${base_URL}common/cities';
  static String get_all_drivers = '${base_URL}driver/list/';
  static String delete_drivers = '${base_URL}driver/delete/';
  static String get_fare = '${base_URL}common/getFare';
  static String charge_user = '${base_URL}user/charge';
  static String update_charge_user = '${base_URL}user/update_payment_status';
}

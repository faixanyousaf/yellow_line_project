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
  static String myrequests_by_status = '${base_URL}user/myrequests_by_status';
  static String charge_user = '${base_URL}user/charge';
  static String update_charge_user = '${base_URL}user/update_payment_status';
  static String update_payment_status = '${base_URL}user/update_payment_status';
  static String update_location = '${base_URL}user/update_location';
  static String get_vehicle = '${base_URL}vehicle/user/list/';
  static String update_user_profile = '${base_URL}authenticated/users/profile';
  static String update_user_profile_picture = '${base_URL}user/update/profile_picture';
  static String get_cites = '${base_URL}common/cities';
}

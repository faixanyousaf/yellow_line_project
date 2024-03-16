import 'base_url.dart';

class ApiRoutes {
  // static String picBaseURL = 'https://cdn.sarya.app/itinerary/';
  // static String avatarURL = 'https://cdn.sarya.app/avatars/';

  ///users authentication
  static String signup = '${base_URL}user/signup';
  static String login = '${base_URL}auth/users/customer';
  static String cities = '${base_URL}common/cities';
  static String get_all_drivers = '${base_URL}driver/list/';
  static String delete_drivers = '${base_URL}driver/delete/';
  //static String forgot = '${base_URL}user/forgotpwd';
  //static String reset = '${base_URL}user/resetpwd';
  //static String update = '${base_URL}user/update';
  //static String delete_account = '${base_URL}user/delete';
  //static String checkDuplicate = '${base_URL}user/checkduplicate';
}

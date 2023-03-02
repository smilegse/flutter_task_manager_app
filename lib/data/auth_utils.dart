import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? token, firstName, lastName, mobile, email, photo;

  static Future<void> saveUserLoginData(
      String uToken,
      String uFirstName,
      String uLastName,
      String uEmail,
      String uMobile,
      String uPhoto) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', uToken);
    await sharedPreferences.setString('firstName', uFirstName);
    await sharedPreferences.setString('lastName', uLastName);
    await sharedPreferences.setString('email', uEmail);
    await sharedPreferences.setString('mobile', uMobile);
    await sharedPreferences.setString('photo', uPhoto);

    firstName = uFirstName;
    lastName = uLastName;
    email = uEmail;
    mobile = uMobile;
    photo = uPhoto;
    token = uToken;
  }

  static Future<bool> checkLoginState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> getAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    token = sharedPreferences.getString('firstName');
    token = sharedPreferences.getString('lastName');
    token = sharedPreferences.getString('email');
    token = sharedPreferences.getString('mobile');
    token = sharedPreferences.getString('photo');
  }

  static Future<void> clearLoginData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

}

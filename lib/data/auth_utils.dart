import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? token, firstName, lastName, mobile, email, photo;

  static Future<void> saveUserData(
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
    firstName = sharedPreferences.getString('firstName');
    lastName = sharedPreferences.getString('lastName');
    email = sharedPreferences.getString('email');
    mobile = sharedPreferences.getString('mobile');
    photo = sharedPreferences.getString('photo');
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

}

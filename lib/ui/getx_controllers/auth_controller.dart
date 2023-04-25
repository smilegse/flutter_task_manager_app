import 'dart:developer';

import 'package:get/get.dart';
import '../../data/auth_utils.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';

class AuthController extends GetxController {
  bool loginInProgress = false;
  bool isObscure = true;

  Future<bool> login(
    String email,
    String password,
  ) async {
    loginInProgress = true;
    update();

    //log('Token before login: ${AuthUtils.token}');

    final result = await NetworkUtils().postMethod(Urls.loginUrl,
        body: {"email": email, "password": password});

    loginInProgress = false;
    //log(result.toString());

    if (result != null && result['status'] == 'success') {
      //log('login success and saved user data');
      await AuthUtils.saveUserData(
          result['token'] ?? '',
          result['data']['firstName'] ?? '',
          result['data']['lastName'] ?? '',
          result['data']['email'] ?? '',
          result['data']['mobile'] ?? '',
          result['data']['photo'] ?? '');
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}

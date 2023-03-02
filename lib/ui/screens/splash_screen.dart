import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_app/data/auth_utils.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_navbar.dart';
import '../widgets/screen_background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      checkUserAuthState();
    });
  }

  void checkUserAuthState() async {
    final bool result = await AuthUtils.checkLoginState();
    if (result) {

      await AuthUtils.getAuthData();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainBottomNavbar()),
          (route) => false);
    }else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Center(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 160,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/screen_background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size ;
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(widget: Center(
          child: SvgPicture.asset('assets/images/logo.svg',
            width: 160,
            fit: BoxFit.scaleDown,
          ),
        ),),
      ),
    );
  }
}



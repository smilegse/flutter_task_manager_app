import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/screen_background_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text('Get Started With', style: screenTitleTextStyle,),
              ),
              const SizedBox(height: 24,),
              AppTextFieldWidget(
                controller: TextEditingController(),
                hintText: 'Email',
              ),
              const SizedBox(height: 16,),
              AppTextFieldWidget(
                  hintText: 'Password',
                  obscureText: true,
                  controller: TextEditingController()
              )
            ],
          ),
        ),
      ),
    );
  }
}



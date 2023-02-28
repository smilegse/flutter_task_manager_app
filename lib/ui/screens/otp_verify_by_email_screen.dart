import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';

import '../utils/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/screen_background_widget.dart';

class OtpVerifyByEmailScreen extends StatefulWidget {
  const OtpVerifyByEmailScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerifyByEmailScreen> createState() => _OtpVerifyByEmailScreenState();
}

class _OtpVerifyByEmailScreenState extends State<OtpVerifyByEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          widget: Padding(
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Email Address ', style: screenTitleTextStyle,),
                  const SizedBox(height: 16,),
                  const Text('A 6 digit verification pin will send to your email address.',
                    style: TextStyle(
                      color: Colors.grey
                  ),),
                  const SizedBox(height: 24,),
                  AppTextFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 24,),
                  AppElevatedButton(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PinVerification()));
                    },
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?",style: TextStyle(
                        fontWeight: FontWeight.w700
                      ),),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                          },
                          child: const Text('Sign Up', style: TextStyle(
                            color: Colors.green,
                              fontWeight: FontWeight.w700
                          ),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

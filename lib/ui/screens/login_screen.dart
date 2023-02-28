import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/otp_verify_by_email_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import '../utils/text_styles.dart';
import '../widgets/app_elevated_button.dart';
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
          widget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Login', style: screenTitleTextStyle,),
                  const SizedBox(height: 24,),
                  AppTextFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 8,),
                  AppTextFieldWidget(
                      hintText: 'Password',
                      obscureText: true,
                      controller: TextEditingController()
                  ),
                  AppElevatedButton(
                    onTap: () {},
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 8,),
                  Center(
                      child: TextButton(
                        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 0,)),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpVerifyByEmailScreen()));
                          },
                          child: const Text('Forgot Password?', style: TextStyle(
                            color: Colors.grey
                          ),))
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account?"),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                          },
                          child: const Text('Sign Up', style: TextStyle(
                              color: Colors.green,
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





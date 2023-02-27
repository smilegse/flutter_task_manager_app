import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';

import '../utils/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/screen_background_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  Text('Sign Up', style: screenTitleTextStyle),
                  const SizedBox(height: 24,),
                  AppTextFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 16,),
                  AppTextFieldWidget(
                      hintText: 'First Name',
                      obscureText: true,
                      controller: TextEditingController()
                  ),
                  const SizedBox(height: 16,),
                  AppTextFieldWidget(
                      hintText: 'Last Name',
                      controller: TextEditingController()
                  ),
                  const SizedBox(height: 16,),
                  AppTextFieldWidget(
                      hintText: 'Mobile',
                      controller: TextEditingController()
                  ),
                  const SizedBox(height: 16,),
                  AppTextFieldWidget(
                      hintText: 'Password',
                      obscureText: true,
                      controller: TextEditingController()
                  ),
                  AppElevatedButton(
                    onTap: () {},
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?"),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: const Text('Sign In', style: TextStyle(
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

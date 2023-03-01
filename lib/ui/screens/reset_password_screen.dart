import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import '../utils/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/screen_background_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set Password ', style: screenTitleTextStyle,),
                  const SizedBox(height: 16,),
                  const Text('Enter a valid password minimum length password 8 character with letter and number combination',
                    style: TextStyle(
                        color: Colors.grey
                    ),),
                  const SizedBox(height: 8,),
                  AppTextFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'Password',
                  ),
                  AppTextFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'Confirm Password',
                  ),
                  const SizedBox(height: 8,),
                  AppElevatedButton(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder:
                          (context) => const LoginScreen()),(route) => false);
                    },
                    child: const Text('Confirm'),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?",style: TextStyle(
                          fontWeight: FontWeight.w700
                      ),),
                      TextButton(
                          onPressed: (){
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder:
                                (context) => const LoginScreen()),(route) => false);
                          },
                          child: const Text('Sign In', style: TextStyle(
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

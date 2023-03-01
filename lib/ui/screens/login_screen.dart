import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/screens/main_bottom_navbar.dart';
import 'package:task_manager_app/ui/screens/otp_verify_by_email_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/utils/snack_bar_message.dart';
import '../../data/network_utils.dart';
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
  final TextEditingController emailETController = TextEditingController();
  final TextEditingController passwordETController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: screenTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppTextFieldWidget(
                      controller: emailETController,
                      hintText: 'Email',
                      validator: (value) =>
                          EmailValidator.validate(emailETController.text)
                              ? null
                              : "Please enter a valid email",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    AppElevatedButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final result = await NetworkUtils().postMethod(
                              Urls.loginUrl,
                              body: {
                                "email": emailETController.text.trim(),
                                "password": passwordETController.text
                              },
                              onUnAuthorize: () {
                                showSnackBarMessage(context, 'Username or password incorrect',true);
                              });

                          if (result != null && result['status'] == 'success') {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => const MainBottomNavbar()),(route) => false);
                          }
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                              vertical: 0,
                            )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OtpVerifyByEmailScreen()));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_utils.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/utils/snack_bar_message.dart';
import '../utils/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/screen_background_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _fromKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set Password ',
                      style: screenTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Enter a valid password minimum length password 8 character with letter and number combination',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      controller: _newPasswordTEController,
                      obscureText: true,
                      hintText: 'Password',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    AppTextFieldWidget(
                      controller: _confirmPasswordTEController,
                      obscureText: true,
                      hintText: 'Confirm Password',
                      validator: (value) {
                        if ((value?.isEmpty ?? true) ||
                            ((value ?? '') != _newPasswordTEController.text)) {
                          return 'Confirm password does not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (_inProgress)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      AppElevatedButton(
                        onTap: () async {
                          if (_fromKey.currentState!.validate()) {
                            final response = await NetworkUtils()
                                .postMethod(Urls.recoverResetPassUrl, body: {
                              "email": widget.email,
                              "OTP": widget.otp,
                              "password": _newPasswordTEController.text
                            });
                            if (response != null &&
                                response['status'] == 'success') {
                              if (mounted) {
                                showSnackBarMessage(
                                    context, 'Password reset done!');

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (route) => false);
                              }
                            } else if (response != null &&
                                response['status'] == 'fail') {
                              if (mounted) {
                                showSnackBarMessage(
                                    context, 'Invalid Request!', true);
                              }
                            } else {
                              if (mounted) {
                                showSnackBarMessage(
                                    context, 'There is something wrong!', true);
                              }
                            }
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700),
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

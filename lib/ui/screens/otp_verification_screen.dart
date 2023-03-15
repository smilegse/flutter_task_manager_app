import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/data/network_utils.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/reset_password_screen.dart';
import 'package:task_manager_app/ui/utils/snack_bar_message.dart';

import '../utils/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/screen_background_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  bool _inProgress = false;

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
                  Text(
                    'PIN Verification ',
                    style: screenTitleTextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'A 6 digit verification pin will send to your email address.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PinCodeTextField(
                    controller: _otpTEController,
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedColor: Colors.green,
                      selectedFillColor: Colors.white70,
                      activeColor: Colors.grey,
                      inactiveColor: Colors.grey,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {
                      log("Completed");
                    },
                    onChanged: (value) {
                      log(value);
                      setState(() {});
                    },
                    beforeTextPaste: (text) {
                      log("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  if (_inProgress)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    AppElevatedButton(
                      onTap: () async {
                        _inProgress = true;
                        setState(() {});

                        final response = await NetworkUtils().getMethod(
                            Urls.recoverVerifyOtpUrl(
                                widget.email, _otpTEController.text.trim()));
                        _inProgress = false;
                        setState(() {});

                        if (response != null &&
                            response['status'] == 'success') {
                          if (mounted) {
                            showSnackBarMessage(
                                context, 'OTP verification done!');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordScreen(
                                        email: widget.email,
                                        otp: _otpTEController.text.trim())));
                          }
                        } else if (response != null &&
                            response['status'] == 'fail') {
                          if (mounted) {
                            showSnackBarMessage(
                                context, 'Invalid OTP code!', true);
                          }
                        } else {
                          if (mounted) {
                            showSnackBarMessage(
                                context, 'There is something wrong!');
                          }
                        }
                      },
                      child: const Text('Verify'),
                    ),
                  const SizedBox(
                    height: 24,
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
                                    builder: (context) => const LoginScreen()),
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
    );
  }
}

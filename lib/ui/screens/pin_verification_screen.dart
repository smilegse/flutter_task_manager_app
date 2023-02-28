import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';

import '../utils/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field_widget.dart';
import '../widgets/screen_background_widget.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({Key? key}) : super(key: key);

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
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
                  Text('PIN Verification ', style: screenTitleTextStyle,),
                  const SizedBox(height: 16,),
                  const Text('A 6 digit verification pin will send to your email address.',
                    style: TextStyle(
                        color: Colors.grey
                    ),),
                  const SizedBox(height: 24,),
                  PinCodeTextField(
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
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  const SizedBox(height: 24,),
                  AppElevatedButton(
                    onTap: () {},
                    child: const Text('Verify'),
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


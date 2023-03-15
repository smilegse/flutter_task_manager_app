import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_utils.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/screens/otp_verification_screen.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';

import '../utils/snack_bar_message.dart';
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

  final TextEditingController _emailTEController = TextEditingController();
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
                    Text('Your Email Address ', style: screenTitleTextStyle,),
                    const SizedBox(height: 16,),
                    const Text('A 6 digit verification pin will send to your email address.',
                      style: TextStyle(
                        color: Colors.grey
                    ),),
                    const SizedBox(height: 24,),
                    AppTextFieldWidget(
                      controller: _emailTEController,
                      hintText: 'Email',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24,),
                    if(_inProgress)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                    AppElevatedButton(
                      onTap: () async {
                        if(_fromKey.currentState!.validate()){

                          _inProgress = true;
                          setState(() {});
                          final response = await NetworkUtils().getMethod(Urls.recoverVerifyEmailUrl(_emailTEController.text.trim()));
                          _inProgress = false;
                          setState(() {});

                          if(response != null && response['status'] == 'success'){
                            if(mounted) {
                              showSnackBarMessage(context, 'Otp sent to the email address');
                              Navigator.push(context,MaterialPageRoute(
                                  builder: (context) => OtpVerificationScreen(email: _emailTEController.text.trim())));
                            }
                          }else if(response != null && response['status'] == 'fail'){
                            if(mounted) {
                              showSnackBarMessage(
                                  context, 'No user found', true);
                            }
                          }
                          else{
                            if(mounted) {
                              showSnackBarMessage(context, 'Otp send failed! Please try again', true);
                            }
                          }
                        }
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
      ),
    );
  }
}

import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snack_bar_message.dart';
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
  final TextEditingController emailETController = TextEditingController();
  final TextEditingController firstNamelETController = TextEditingController();
  final TextEditingController lastNamelETController = TextEditingController();
  final TextEditingController mobileETController = TextEditingController();
  final TextEditingController passwordETController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late bool _inProgress = false;

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
                    Text('Sign Up', style: screenTitleTextStyle),
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
                      hintText: 'First Name',
                      controller: firstNamelETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      hintText: 'Last Name',
                      controller: lastNamelETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppTextFieldWidget(
                      hintText: 'Mobile',
                      controller: mobileETController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your mobile number';
                        }
                        return null;
                      },
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
                          return 'Enter valid password more than 6 characters';
                        } else if((value?.length ?? 0) < 6){
                          return 'Enter password more than 6 characters';
                        }
                        return null;
                      },
                    ),
                    if(_inProgress)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    else
                      AppElevatedButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _inProgress = true;
                          });
                          final result = await NetworkUtils().postMethod(
                              Urls.registrationUrl,
                              body: {
                                "email": emailETController.text,
                                "firstName": firstNamelETController.text,
                                "lastName": lastNamelETController.text,
                                "mobile": mobileETController.text,
                                "password": passwordETController.text
                              },
                              onUnAuthorize: () {
                                showSnackBarMessage(context, 'Username or password incorrect',true);
                              });

                          setState(() {
                            _inProgress = false;
                          });

                          if (result != null && result['status'] == 'success') {
                            emailETController.clear();
                            firstNamelETController.clear();
                            lastNamelETController.clear();
                            mobileETController.clear();
                            passwordETController.clear();
                            showSnackBarMessage(
                                context, 'Registration Success!');
                          } else {
                            showSnackBarMessage(context,
                                'Registration failed! Try again later...', true);
                          }
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: const Text(
                              'Sign In',
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

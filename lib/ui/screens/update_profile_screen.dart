import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/utils/text_styles.dart';
import 'package:task_manager_app/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_app/ui/widgets/screen_background_widget.dart';
import 'package:task_manager_app/ui/widgets/user_profile_widget.dart';

import '../widgets/app_text_field_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileWidget(),
            Expanded(
              child: ScreenBackground(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24,),
                        Text('Update Profile', style: screenTitleTextStyle),
                        const SizedBox(height: 16,),
                        InkWell(
                          onTap: (){

                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ) ,
                                child: const Text('Photo'),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ) ,
                                  child: const Text(''),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8,),
                        AppTextFieldWidget(
                          controller: TextEditingController(),
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 8,),
                        AppTextFieldWidget(
                          controller: TextEditingController(),
                          hintText: 'First Name',
                        ),
                        const SizedBox(height: 8,),
                        AppTextFieldWidget(
                          controller: TextEditingController(),
                          hintText: 'Last Name',
                        ),
                        const SizedBox(height: 8,),
                        AppTextFieldWidget(
                          controller: TextEditingController(),
                          hintText: 'Mobile',
                        ),
                        const SizedBox(height: 8,),
                        AppTextFieldWidget(
                          controller: TextEditingController(),
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 16,),
                        AppElevatedButton(
                          child: const Icon(Icons.arrow_circle_right_outlined),
                            onTap: (){
                          }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

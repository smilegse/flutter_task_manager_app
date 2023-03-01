import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/utils/text_styles.dart';
import 'package:task_manager_app/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_app/ui/widgets/screen_background_widget.dart';
import 'package:task_manager_app/ui/widgets/user_profile_widget.dart';

import '../widgets/app_text_field_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
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
                        Text('Add New Task', style: screenTitleTextStyle),
                        const SizedBox(height: 16,),
                        AppTextFieldWidget(
                          controller: TextEditingController(),
                          hintText: 'Subject',
                        ),
                        const SizedBox(height: 8,),
                        AppTextFieldWidget(
                          controller: TextEditingController(),
                          hintText: 'Descriptions',
                          maxLines: 5,
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

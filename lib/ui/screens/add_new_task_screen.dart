import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_utils.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/utils/text_styles.dart';
import 'package:task_manager_app/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_app/ui/widgets/screen_background_widget.dart';
import 'package:task_manager_app/ui/widgets/user_profile_widget.dart';

import '../../data/auth_utils.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/app_text_field_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController subjectTEController = TextEditingController();
  final TextEditingController descTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserProfileWidget(),
              Expanded(
                child: ScreenBackground(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24,),
                            Text('Add New Task', style: screenTitleTextStyle),
                            const SizedBox(height: 16,),
                            AppTextFieldWidget(
                              controller: subjectTEController,
                              hintText: 'Subject',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Enter your task subject';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8,),
                            AppTextFieldWidget(
                              controller: descTEController,
                              hintText: 'Descriptions',
                              maxLines: 5,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Enter your task descriptions';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16,),
                            if(_inProgress)
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                            else
                              AppElevatedButton(
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _inProgress = true;
                                      });
                                      final result = await NetworkUtils().postMethod(
                                          Urls.createTaskUrl,
                                          body: {
                                            "title":subjectTEController.text.trim(),
                                            "description": descTEController.text.trim(),
                                            "status":"New"
                                          }, onUnAuthorize: () {
                                            showSnackBarMessage(context,
                                            'You are not authorized', true);
                                          });

                                      setState(() {
                                        _inProgress = false;
                                      });

                                      if(result != null && result['status'] == 'success'){

                                        subjectTEController.clear();
                                        descTEController.clear();

                                        if(mounted){
                                          showSnackBarMessage(context,
                                            'New task added successfully');
                                        }
                                      }else {
                                        if(mounted) {
                                          showSnackBarMessage(context,
                                              'New task add failed! Try again',
                                              true);
                                        }
                                      }

                                    }
                                  }
                              ),
                          ],
                        ),
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

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/auth_utils.dart';
import 'package:task_manager_app/data/network_utils.dart';
import 'package:task_manager_app/data/urls.dart';
import 'package:task_manager_app/ui/utils/snack_bar_message.dart';
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

final TextEditingController _emailTEController = TextEditingController();
final TextEditingController _firstNameTEController = TextEditingController();
final TextEditingController _lastNameTEController = TextEditingController();
final TextEditingController _mobileTEController = TextEditingController();
final TextEditingController _passwordTEController = TextEditingController();
//final TextEditingController _photoTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

XFile? pickedImage;
String? base64Image;

@override
  void initState() {
    super.initState();

    _emailTEController.text = AuthUtils.email ?? '';
    _firstNameTEController.text = AuthUtils.firstName ?? '';
    _lastNameTEController.text = AuthUtils.lastName ?? '';
    _mobileTEController.text = AuthUtils.mobile ?? '';
    //_photoTEController.text = AuthUtils.photo ?? '';

  }


  void updateProfile() async{

    if(pickedImage != null) {
      List<int> imageBytes = await pickedImage!.readAsBytes();
      log(imageBytes.toString());
      base64Image = base64Encode(imageBytes);
    }

    final result =await NetworkUtils().postMethod(Urls.profileUpdateUrl, body: {
      "mobile": _mobileTEController.text.trim(),
      "photo": base64Image
    });

    if(result != null && result['status'] == 'success'){
      AuthUtils.saveUserData(
        AuthUtils.token ?? '',
        AuthUtils.firstName ?? '',
        AuthUtils.lastName ?? '',
        AuthUtils.email ?? '',
        _mobileTEController.text.trim(),
        AuthUtils.photo ?? '',
      );

      if(mounted) {
        showSnackBarMessage(context, 'Profile data updated!');
      }
    }else {
      if(mounted) {
        showSnackBarMessage(context, 'Profile data update failed!',true);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24,),
                          Text('Update Profile', style: screenTitleTextStyle),
                          const SizedBox(height: 16,),
                          InkWell(
                            onTap: () async {
                              pickImage();
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
                                    child: Text(pickedImage?.name ?? '',
                                      maxLines: 1, style: const TextStyle(
                                      overflow: TextOverflow.ellipsis
                                    ),),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8,),
                          AppTextFieldWidget(
                            controller: _emailTEController,
                            hintText: 'Email',
                            readOnly: true,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8,),
                          AppTextFieldWidget(
                            controller: _firstNameTEController,
                            hintText: 'First Name',
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter your first name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8,),
                          AppTextFieldWidget(
                            controller: _lastNameTEController,
                            hintText: 'Last Name',
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter your last name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8,),
                          AppTextFieldWidget(
                            controller: _mobileTEController,
                            hintText: 'Mobile',
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter your mobile';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8,),
                          AppTextFieldWidget(
                            controller: _passwordTEController,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 16,),
                          AppElevatedButton(
                            child: const Icon(Icons.arrow_circle_right_outlined),
                              onTap: (){
                              if(_formKey.currentState!.validate()){
                                updateProfile();
                              }

                            }),
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


  void pickImage() async {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Pick image from'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () async {
                pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

                if(pickedImage != null){
                  setState(() {

                  });
                }
              },
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
            ),
            ListTile(
                onTap: () async {
                  pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

                  if(pickedImage != null){
                    setState(() {

                    });
                  }
                },
                leading: const Icon(Icons.photo),
                title: const Text('Gallery')
            ),
          ],
        ),
      );
    });


  }


}



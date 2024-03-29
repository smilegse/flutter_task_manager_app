import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.maxLines,
    this.validator,
    this.readOnly
  });

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText ;
  final int? maxLines;
  final bool? readOnly;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false ,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      validator: (value) {
        if(validator != null) {
          return validator!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: hintText,
        labelText: hintText,
        filled: true, border: const OutlineInputBorder(borderSide: BorderSide.none),

      ),
    );
  }
}
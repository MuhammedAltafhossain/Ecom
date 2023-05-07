import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
typedef StringValue = String Function(String);

class AddTextFieldWidget extends StatelessWidget {
  const AddTextFieldWidget({
    super.key, required this.controller, this.hintText, this.maxLines, this.validator,
  });

  final TextEditingController controller;
  final String? hintText ;
  final int? maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLines: maxLines ?? 1,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

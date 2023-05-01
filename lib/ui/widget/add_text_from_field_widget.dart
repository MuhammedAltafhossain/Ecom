import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AddTextFieldWidget extends StatelessWidget {
  const AddTextFieldWidget({
    super.key, required this.controller, required this.hintText, this.maxLines,
  });

  final TextEditingController controller;
  final String hintText ;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
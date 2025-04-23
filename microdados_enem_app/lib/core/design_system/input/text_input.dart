import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isSuccess;
  final bool disable;
  final String? label;
  final String? error;
  final ValueChanged<String>? onChanged;

  const TextInput({
    super.key,
    required this.controller,
    this.label,
    this.disable = false,
    this.inputType = TextInputType.text,
    this.isSuccess = false,
    this.error,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: AppColors.bluePrimary,
      readOnly: disable,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelText: label,
        errorText: error,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: isSuccess ? AppColors.greenPrimary : AppColors.bluePrimary,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.bluePrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.bluePrimary),
        ),
      ),
      keyboardType: inputType,
    );
  }
}

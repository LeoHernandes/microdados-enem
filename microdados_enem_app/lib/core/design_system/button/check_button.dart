import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class CheckButton extends StatelessWidget {
  final bool checked;
  final String text;
  final VoidCallback onCheck;

  const CheckButton({
    super.key,
    required this.checked,
    required this.text,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            checked ? AppColors.blueLighest : AppColors.whitePrimary,
        foregroundColor: AppColors.blueLighest,
        side: BorderSide(color: AppColors.bluePrimary),
        minimumSize: Size(0, 0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
      ),
      onPressed: onCheck,
      child: AppText(
        text: text,
        typography: AppTypography.subtitle2,
        color: AppColors.bluePrimary,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:microdados_enem_app/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/design_system/styles/colors.dart';
import 'package:microdados_enem_app/design_system/styles/typography.dart';

enum ButtonType { primary, secondary }

class Button extends StatelessWidget {
  final ButtonType type;
  final Size size;
  final VoidCallback onPressed;
  final String text;

  const Button.primary({
    super.key,
    required this.size,
    required this.onPressed,
    required this.text,
  }) : type = ButtonType.primary;

  const Button.secondary({
    super.key,
    required this.size,
    required this.onPressed,
    required this.text,
  }) : type = ButtonType.secondary;

  @override
  Widget build(BuildContext build) {
    return TextButton(
      style: switch (type) {
        ButtonType.primary => TextButton.styleFrom(
          backgroundColor: AppColors.bluePrimary,
          foregroundColor: AppColors.blueLigher,
          minimumSize: size,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
        ),
        ButtonType.secondary => TextButton.styleFrom(
          backgroundColor: AppColors.whitePrimary,
          foregroundColor: AppColors.blueLighest,
          side: BorderSide(color: AppColors.bluePrimary),
          minimumSize: size,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
        ),
      },
      onPressed: onPressed,
      child: AppText(
        text: 'Iniciar',
        typography: AppTypography.button,
        color: switch (type) {
          ButtonType.primary => AppColors.whitePrimary,
          ButtonType.secondary => AppColors.bluePrimary,
        },
      ),
    );
  }
}

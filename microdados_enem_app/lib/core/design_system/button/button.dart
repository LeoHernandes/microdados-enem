import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

enum ButtonType { primary, secondary, terciary }

class Button extends StatelessWidget {
  final ButtonType type;
  final Size size;
  final String text;
  final bool disable;
  final VoidCallback? onPressed;
  final bool loading;

  const Button.primary({
    super.key,
    required this.size,
    required this.text,
    this.onPressed,
    this.disable = false,
    this.loading = false,
  }) : type = ButtonType.primary;

  const Button.secondary({
    super.key,
    required this.size,
    required this.text,
    this.onPressed,
    this.disable = false,
    this.loading = false,
  }) : type = ButtonType.secondary;

  const Button.terciary({
    super.key,
    required this.size,
    required this.text,
    this.onPressed,
    this.disable = false,
    this.loading = false,
  }) : type = ButtonType.terciary;

  @override
  Widget build(BuildContext build) {
    return TextButton(
      style: switch (type) {
        ButtonType.primary => TextButton.styleFrom(
          backgroundColor:
              disable || loading ? AppColors.blueLigher : AppColors.bluePrimary,
          foregroundColor: AppColors.blueLigher,
          minimumSize: size,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
        ),
        ButtonType.secondary => TextButton.styleFrom(
          backgroundColor:
              disable || loading
                  ? AppColors.blueLighest
                  : AppColors.whitePrimary,
          foregroundColor: AppColors.blueLighest,
          side: BorderSide(color: AppColors.bluePrimary),
          minimumSize: size,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
        ),
        ButtonType.terciary => TextButton.styleFrom(
          backgroundColor:
              disable || loading
                  ? AppColors.blueLighest
                  : AppColors.whitePrimary,
          foregroundColor: AppColors.blueLighest,
          minimumSize: size,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(36)),
          ),
        ),
      },
      onPressed: disable || loading ? () {} : onPressed,
      child:
          loading
              ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(switch (type) {
                    ButtonType.primary => AppColors.whitePrimary,
                    ButtonType.secondary => AppColors.bluePrimary,
                    ButtonType.terciary => AppColors.bluePrimary,
                  }),
                ),
              )
              : AppText(
                text: text,
                typography: AppTypography.button,
                color: switch (type) {
                  ButtonType.primary => AppColors.whitePrimary,
                  ButtonType.secondary => AppColors.bluePrimary,
                  ButtonType.terciary => AppColors.bluePrimary,
                },
              ),
    );
  }
}

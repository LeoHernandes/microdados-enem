import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class GenericError extends StatelessWidget {
  final String text;
  final VoidCallback refetch;

  const GenericError({super.key, required this.text, required this.refetch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: AppColors.yellowPrimary,
          size: 64,
        ),
        SizedBox(height: 20),

        AppText(
          text: text,
          color: AppColors.blackPrimary,
          typography: AppTypography.subtitle1,
          align: TextAlign.center,
        ),
        SizedBox(height: 20),

        Button.terciary(
          size: Size(80, 36),
          text: 'Tentar novamente',
          onPressed: refetch,
        ),
      ],
    );
  }
}

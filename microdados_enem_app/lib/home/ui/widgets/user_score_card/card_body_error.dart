import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class CardBodyError extends StatelessWidget {
  final VoidCallback refetch;

  const CardBodyError({super.key, required this.refetch});

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
          text: 'Não foi possível encontrar as informações',
          color: AppColors.blackPrimary,
          typography: AppTypography.subtitle1,
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

import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class DifficultyLineChart extends StatelessWidget {
  final Map<int, double?> data;

  const DifficultyLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Dificuldade das questões na prova',
            typography: AppTypography.subtitle1,
            color: AppColors.blackPrimary,
          ),

          SizedBox(
            height: 300,
            child: AppText(
              text: 'TODO: line chart',
              typography: AppTypography.caption,
              color: AppColors.redPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

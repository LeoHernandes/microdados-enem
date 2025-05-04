import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

class ScoreSummary extends StatelessWidget {
  final String minScore;
  final String maxScore;
  final ExamArea area;
  final int rightAnswers;

  const ScoreSummary({
    super.key,
    required this.minScore,
    required this.maxScore,
    required this.area,
    required this.rightAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Pontuações com $rightAnswers acertos',
            typography: AppTypography.subtitle1,
            color: AppColors.blackPrimary,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Nota mínima',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text: minScore,
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: AppColors.blackLightest,
              thickness: 0.5,
              height: 0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Nota máxima',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text: maxScore,
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

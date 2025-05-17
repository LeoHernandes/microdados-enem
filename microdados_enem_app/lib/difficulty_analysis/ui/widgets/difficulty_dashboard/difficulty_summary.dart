import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/difficulty_analysis/data/difficulty_analysis_repository.dart';

class DifficultySummary extends StatelessWidget {
  final QuestionDifficulty easiestQuestion;
  final QuestionDifficulty hardestQuestion;

  const DifficultySummary({
    super.key,
    required this.easiestQuestion,
    required this.hardestQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Resumo da dificuldade das questões',
            typography: AppTypography.subtitle1,
            color: AppColors.blackPrimary,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Mais fácil',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text:
                    'Questão ${easiestQuestion.position} (${easiestQuestion.difficulty.toStringAsFixed(2)})',
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
                text: 'Mais difícil',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text:
                    'Questão ${hardestQuestion.position} (${hardestQuestion.difficulty.toStringAsFixed(2)})',
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

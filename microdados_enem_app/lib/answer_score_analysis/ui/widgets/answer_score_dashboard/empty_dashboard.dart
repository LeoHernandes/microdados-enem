import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

class EmptyDashboard extends StatelessWidget {
  final ExamArea area;
  final int rightAnswers;

  const EmptyDashboard({
    super.key,
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
            text: 'Não temos informações para essa busca',
            typography: AppTypography.subtitle1,
            color: AppColors.blackPrimary,
          ),
          SizedBox(height: 8),
          AppText(
            text:
                'É possível que questões tenham sido anuladas na prova de ${area.displayName}, impedindo que participantes obtivessem $rightAnswers acertos.',
            typography: AppTypography.body2,
            color: AppColors.blackPrimary,
          ),
        ],
      ),
    );
  }
}

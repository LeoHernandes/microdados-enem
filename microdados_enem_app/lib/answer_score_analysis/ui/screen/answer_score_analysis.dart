import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_bottomsheet/app_bottomsheet.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/dotted_line/dotted_line.dart';
import 'package:microdados_enem_app/core/design_system/exam_area_picker/exam_area_picker.dart';
import 'package:microdados_enem_app/core/design_system/input/numeric_step_button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/answer_score_analysis/logic/answer_score_relation_cubit.dart';
import 'package:microdados_enem_app/answer_score_analysis/logic/canceled_questions_count_cubit.dart';
import 'package:microdados_enem_app/answer_score_analysis/logic/participant_score_on_area_cubit.dart';
import 'package:microdados_enem_app/answer_score_analysis/ui/widgets/answer_score_dashboard/answer_score_dashboard.dart';
import 'package:microdados_enem_app/answer_score_analysis/ui/widgets/canceled_questions_alert.dart';
import 'package:microdados_enem_app/answer_score_analysis/ui/widgets/user_score_on_area.dart';

class AnswerScoreAnalysis extends HookWidget {
  const AnswerScoreAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedArea = useState<ExamArea>(ExamArea.LC);
    final rightAnswers = useState<int>(40);

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: 'Número de acertos e pontuação',
                typography: AppTypography.headline6,
                color: AppColors.blackPrimary,
              ),
              AppIconButton(
                icon: Icons.info_outline_rounded,
                border: false,
                onTap:
                    () => AppBottomsheet(
                      builder: explanationBuilder,
                      onPrimaryButtonTap: () => Navigator.pop(context),
                    ).show(context),
              ),
            ],
          ),
          SizedBox(height: 10),
          AppText(
            text: 'Número de acertos',
            typography: AppTypography.subtitle2,
            color: AppColors.blackLight,
          ),
          SizedBox(height: 2),
          NumericStepButton(
            maxValue: 45,
            minValue: 1,
            onChanged: (number) => rightAnswers.value = number,
            initialValue: 40,
          ),
          SizedBox(height: 10),
          AppText(
            text: 'Área do conhecimento',
            typography: AppTypography.subtitle2,
            color: AppColors.blackLight,
          ),
          SizedBox(height: 2),
          ExamAreaPicker(
            onChange: (area, _) => selectedArea.value = area,
            area: selectedArea.value,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: DottedDivider(),
          ),
          BlocProvider(
            create: (_) => CanceledQuestionsCountCubit(),
            child: CanceledQuestionsAlert(area: selectedArea.value),
          ),
          BlocProvider(
            create: (_) => AnswerScoreRelationCubit(),
            child: AnswerScoreDashboard(
              rightAnswers: rightAnswers.value,
              area: selectedArea.value,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: DottedDivider(),
          ),
          BlocProvider(
            create: (_) => ParticipantScoreOnAreaCubit(),
            child: UserScoreOnArea(area: selectedArea.value),
          ),
        ],
      ),
    );
  }

  Widget explanationBuilder(BuildContext context) {
    return Column(
      children: [
        BottomsheetTitle(text: 'Como funciona?'),
        SizedBox(height: 8),
        BottomsheetBodyText(
          text:
              'Nessa análise, você verá em cada área qual foi a distribuição de pontuações considerando um número de acertos, podendo verificar a menor e maior nota.',
        ),
        SizedBox(height: 8),

        BottomsheetBodyText(
          text:
              'Você pode alterar a área e o número de acertos para avaliar a influência das diferentes questões sobre a nota final. Observe a importância de acertar as questões com baixa dificuldade e manter uma coerência pedagógica na sua performance.',
        ),
      ],
    );
  }
}

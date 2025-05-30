import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_bottomsheet/app_bottomsheet.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/dotted_line/dotted_line.dart';
import 'package:microdados_enem_app/core/design_system/exam_area_picker/exam_area_picker.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/enem/foreign_language.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/difficulty_distribution_cubit.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/participant_pedagogical_coherence_cubit.dart';
import 'package:microdados_enem_app/difficulty_analysis/ui/widgets/difficulty_dashboard/difficulty_distribution_dashboard.dart';
import 'package:microdados_enem_app/difficulty_analysis/ui/widgets/participant_difficulty_rule.dart';

class DifficultyAnalysis extends HookWidget {
  const DifficultyAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedArea = useState<ExamArea>(ExamArea.LC);
    final selectedLanguage = useState<ForeignLanguage?>(ForeignLanguage.EN);

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AppText(
                  text: 'Distribuição de dificuldade',
                  typography: AppTypography.headline6,
                  color: AppColors.blackPrimary,
                ),
              ),
              AppIconButton(
                size: 22,
                iconSize: 12,
                tooltip: 'Ajuda',
                icon: Icons.question_mark_rounded,
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
            text: 'Área do conhecimento',
            typography: AppTypography.subtitle2,
            color: AppColors.blackLight,
          ),
          SizedBox(height: 2),
          ExamAreaPicker(
            onChange: (area, language) {
              selectedArea.value = area;
              selectedLanguage.value = language;
            },
            area: selectedArea.value,
            language: selectedLanguage.value,
            pickLanguage: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: DottedDivider(),
          ),
          BlocProvider(
            create: (_) => DifficultyDistributionCubit(),
            child: DifficultyDistributionDashboard(
              area: selectedArea.value,
              language: selectedLanguage.value,
            ),
          ),
          BlocProvider(
            create: (_) => ParticipantPedagogicalCoherenceCubit(),
            child: ParticipantDifficultyRule(area: selectedArea.value),
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
              'Nessa análise, você verá a distribuição da dificuldade através das questões de cada área do exame, podendo avliar a variância dessa característica e inferir um nível de complexidade geral da prova.',
        ),
        SizedBox(height: 8),

        BottomsheetBodyText(
          text:
              'Os valores da dificuldade de cada questão foram normalizados para melhorar sua visualização, mas todas as proporções foram mantidas para não afetar nenhuma análise.',
        ),
      ],
    );
  }
}

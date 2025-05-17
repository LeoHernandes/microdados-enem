import 'package:flutter/material.dart';
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
              AppText(
                text: 'Distribuição de dificuldade',
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

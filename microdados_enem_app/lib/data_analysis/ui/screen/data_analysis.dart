import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_bottomsheet/app_bottomsheet.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/exam_area_picker/exam_area_picker.dart';
import 'package:microdados_enem_app/core/design_system/input/numeric_step_button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class DataAnalysis extends HookWidget {
  const DataAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarText: 'Análises',
      selectedTab: NavTab.dataAnalysis,
      body: Column(
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
            onChanged: (_) {},
            initialValue: 45,
          ),
          SizedBox(height: 10),
          AppText(
            text: 'Área do conhecimento',
            typography: AppTypography.subtitle2,
            color: AppColors.blackLight,
          ),
          SizedBox(height: 2),
          ExamAreaPicker(onAreaSelect: (_) {}),
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
              'Nessa análise, você verá em cada área qual foi a maior e menor pontuação considerando um número de acertos. Isso permite avaliar a influência das diferentes questões sobre a nota final numa área de conhecimento.',
        ),
      ],
    );
  }
}

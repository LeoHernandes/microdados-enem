import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/check_button.dart';
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
          AppCard(
            border: true,
            body: AppText(
              text:
                  'Nessa análise, você verá em cada área qual foi a maior e menor pontuação considerando um número de acertos. Isso permite avaliar a influência das diferentes questões sobre a nota final numa área de conhecimento.',
              typography: AppTypography.body2,
              color: AppColors.blackPrimary,
              align: TextAlign.justify,
            ),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
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
}

enum ExamArea { CH, CN, LC, MT }

class ExamAreaPicker extends HookWidget {
  final ValueChanged<ExamArea> onAreaSelect;

  const ExamAreaPicker({super.key, required this.onAreaSelect});

  @override
  Widget build(BuildContext context) {
    final selectedArea = useState<ExamArea>(ExamArea.LC);

    return Wrap(
      spacing: 10,
      children: [
        CheckButton(
          checked: selectedArea.value == ExamArea.LC,
          text: 'Linguagens',
          onCheck: () {
            onAreaSelect(ExamArea.LC);
            selectedArea.value = ExamArea.LC;
          },
        ),
        CheckButton(
          checked: selectedArea.value == ExamArea.CH,
          text: 'Ciências Humanas',
          onCheck: () {
            onAreaSelect(ExamArea.CH);
            selectedArea.value = ExamArea.CH;
          },
        ),
        CheckButton(
          checked: selectedArea.value == ExamArea.MT,
          text: 'Matemática',
          onCheck: () {
            onAreaSelect(ExamArea.MT);
            selectedArea.value = ExamArea.MT;
          },
        ),
        CheckButton(
          checked: selectedArea.value == ExamArea.CN,
          text: 'Ciências da Natureza',
          onCheck: () {
            onAreaSelect(ExamArea.CN);
            selectedArea.value = ExamArea.CN;
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/design_system/text_input/text_input.dart';

class DataAnalysis extends StatelessWidget {
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
          NumericStepButton(
            maxValue: 45,
            minValue: 1,
            onChanged: (_) {},
            initialValue: 45,
          ),
        ],
      ),
    );
  }
}

class NumericStepButton extends HookWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;

  final ValueChanged<int> onChanged;

  const NumericStepButton({
    super.key,
    required this.minValue,
    required this.maxValue,
    this.initialValue = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue.toString());
    final textValue = useValueListenable(controller);

    void handleValueChange(int newValue) {
      final clampedValue = newValue.clamp(minValue, maxValue);
      controller.text = clampedValue.toString();
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      onChanged(clampedValue);
    }

    final currentValue = int.tryParse(textValue.text) ?? initialValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextInput(
            controller: controller,
            inputType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                final newValue = int.tryParse(value);
                if (newValue != null) handleValueChange(newValue);
              }
            },
          ),
        ),
        SizedBox(width: 10),
        AppIconButton(
          icon: Icons.remove,
          onTap:
              currentValue == minValue
                  ? null
                  : () => handleValueChange(currentValue - 1),
        ),
        SizedBox(width: 10),
        AppIconButton(
          icon: Icons.add,
          onTap:
              currentValue == maxValue
                  ? null
                  : () => handleValueChange(currentValue + 1),
        ),
      ],
    );
  }
}

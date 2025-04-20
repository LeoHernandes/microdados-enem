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
    final counter = useState(this.initialValue);
    final controller = useTextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconButton(
          icon: Icons.remove,
          onTap:
              counter.value == this.minValue
                  ? null
                  : () => this.onChanged(--counter.value),
        ),
        SizedBox(width: 10),
        Expanded(child: TextInput(controller: controller)),
        SizedBox(width: 10),
        AppIconButton(
          icon: Icons.add,
          onTap:
              counter.value == this.maxValue
                  ? null
                  : () => this.onChanged(++counter.value),
        ),
      ],
    );
  }
}

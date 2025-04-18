import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/progress_dots.dart';

class WarningStep extends StatelessWidget {
  final VoidCallback onNextStep;

  const WarningStep({super.key, required this.onNextStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image(image: AssetImage('assets/onboarding/step2.png')),
        SizedBox(height: 40),
        AppText(
          text: 'Antes de tudo, um lembrete',
          typography: AppTypography.headline6,
          color: AppColors.bluePrimary,
        ),
        SizedBox(height: 20),
        AppText(
          text:
              'Embora este aplicativo obedeça às normas da LGPD e utilize elementos visuais de acordo com o Padrão Digital do Governo do Brasil, não se trata de uma ferramenta oficial do INEP.',
          typography: AppTypography.body1,
          color: AppColors.blackLight,
          align: TextAlign.justify,
        ),
        SizedBox(height: 80),
        Button.primary(
          size: Size(160, 36),
          onPressed: onNextStep,
          text: 'ENTENDI',
        ),
        SizedBox(height: 40),
        ProgressDots(totalSteps: 4, currentStep: 2),
      ],
    );
  }
}

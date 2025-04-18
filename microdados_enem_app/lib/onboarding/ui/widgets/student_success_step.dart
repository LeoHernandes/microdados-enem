import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/progress_dots.dart';

class StudentSuccessStep extends StatelessWidget {
  final VoidCallback onNextStep;

  const StudentSuccessStep({super.key, required this.onNextStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image(image: AssetImage('assets/onboarding/step3.png')),
        SizedBox(height: 20),
        Button.secondary(
          size: Size(160, 36),
          text: 'SOU ESTUDANTE',
          disable: true,
        ),
        SizedBox(height: 40),
        AppText(
          text: 'Feito!',
          typography: AppTypography.headline6,
          color: AppColors.bluePrimary,
        ),
        SizedBox(height: 20),
        AppText(
          text:
              'Tudo pronto para você mergulhar nos dados e alavancar ainda mais seus estudos!',
          typography: AppTypography.body1,
          color: AppColors.blackLight,
          align: TextAlign.justify,
        ),
        SizedBox(height: 80),
        Button.primary(
          size: Size(160, 36),
          onPressed: onNextStep,
          text: 'COMEÇAR',
        ),
        SizedBox(height: 40),
        ProgressDots(totalSteps: 4, currentStep: 4),
      ],
    );
  }
}

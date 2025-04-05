import 'package:flutter/material.dart';
import 'package:microdados_enem_app/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/design_system/buttons/buttons.dart';
import 'package:microdados_enem_app/design_system/styles/colors.dart';
import 'package:microdados_enem_app/design_system/styles/typography.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/progress_dots.dart';

class WelcomeStep extends StatelessWidget {
  final VoidCallback onNextStep;

  const WelcomeStep({super.key, required this.onNextStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 56),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(image: AssetImage('assets/onboarding/step1.png')),
          SizedBox(height: 40),
          AppText(
            text: 'Boas vindas ao Microdados Enem!',
            typography: AppTypography.headline6,
            color: AppColors.bluePrimary,
          ),
          SizedBox(height: 40),
          AppText(
            text:
                'Aqui você consegue visualizar e analisar tudo sobre o exame de forma interativa!',
            typography: AppTypography.body1,
            color: AppColors.blackLight,
          ),
          SizedBox(height: 80),
          Button.primary(
            size: Size(160, 36),
            onPressed: onNextStep,
            text: 'INICIAR',
          ),
          SizedBox(height: 40),
          ProgressDots(totalSteps: 4, currentStep: 0),
        ],
      ),
    );
  }
}

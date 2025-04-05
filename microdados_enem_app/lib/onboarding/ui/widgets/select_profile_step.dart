import 'package:flutter/material.dart';
import 'package:microdados_enem_app/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/design_system/buttons/buttons.dart';
import 'package:microdados_enem_app/design_system/styles/colors.dart';
import 'package:microdados_enem_app/design_system/styles/typography.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/progress_dots.dart';

enum ProfileType { student, teacher }

class SelectProfileStep extends StatelessWidget {
  final void Function(ProfileType) onNextStep;

  const SelectProfileStep({super.key, required this.onNextStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image(image: AssetImage('assets/onboarding/step3.png')),
        SizedBox(height: 40),
        AppText(
          text: 'Seu perfil',
          typography: AppTypography.headline6,
          color: AppColors.bluePrimary,
        ),
        SizedBox(height: 20),
        AppText(
          text: 'Para começar, conte para gente um pouco sobre você.',
          typography: AppTypography.body1,
          color: AppColors.blackLight,
          align: TextAlign.justify,
        ),
        SizedBox(height: 80),
        Button.secondary(
          text: 'SOU ESTUDANTE',
          onPressed: () => onNextStep(ProfileType.student),
          size: Size(160, 36),
        ),
        SizedBox(height: 10),
        Button.secondary(
          text: 'SOU PROFESSOR',
          onPressed: () => onNextStep(ProfileType.teacher),
          size: Size(160, 36),
        ),
        SizedBox(height: 40),
        ProgressDots(totalSteps: 4, currentStep: 3),
      ],
    );
  }
}

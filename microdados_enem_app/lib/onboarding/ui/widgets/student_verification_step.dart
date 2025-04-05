import 'package:flutter/material.dart';
import 'package:microdados_enem_app/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/design_system/buttons/buttons.dart';
import 'package:microdados_enem_app/design_system/styles/colors.dart';
import 'package:microdados_enem_app/design_system/styles/typography.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/progress_dots.dart';

class StudentVerificationStep extends StatelessWidget {
  final VoidCallback onNextStep;

  const StudentVerificationStep({super.key, required this.onNextStep});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight, // Fill available height
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Push ALL content to bottom
              children: [
                Image(image: AssetImage('assets/onboarding/step3.png')),
                SizedBox(height: 10),
                Button.secondary(
                  size: Size(160, 36),
                  text: 'SOU ESTUDANTE',
                  disable: true,
                ),
                SizedBox(height: 20),
                AppText(
                  text:
                      'Muito bem! Para ter acesso a todas as funcionalidades, informe seu número de inscrição do Enem 2023.',
                  typography: AppTypography.body1,
                  color: AppColors.blackLight,
                  align: TextAlign.justify,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Número de inscrição',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: AppColors.bluePrimary),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Button.secondary(
                      size: Size(160, 36),
                      onPressed: onNextStep,
                      text: 'PULAR',
                    ),
                    SizedBox(width: 16),
                    Button.primary(
                      size: Size(160, 36),
                      onPressed: () {},
                      text: 'VERIFICAR',
                    ),
                  ],
                ),
                SizedBox(height: 40),
                ProgressDots(totalSteps: 4, currentStep: 4),
              ],
            ),
          ),
        );
      },
    );
  }
}

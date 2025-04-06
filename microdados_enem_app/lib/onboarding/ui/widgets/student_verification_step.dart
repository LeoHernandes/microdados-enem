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
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Número de inscrição',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.bluePrimary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.bluePrimary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton.outlined(
                      onPressed:
                          () => _showSubscriptionNumberExplanation(context),
                      icon: Icon(
                        Icons.question_mark,
                        color: AppColors.bluePrimary,
                      ),
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(color: AppColors.bluePrimary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button.secondary(
                      size: Size(160, 36),
                      onPressed: onNextStep,
                      text: 'PULAR',
                    ),
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

  void _showSubscriptionNumberExplanation(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.whitePrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AppText(
                    text: 'Uso do número de inscrição',
                    typography: AppTypography.subtitle1,
                    color: AppColors.blackPrimary,
                  ),
                ],
              ),
              SizedBox(height: 8),
              AppText(
                text:
                    'O seu número de inscrição no Enem 2023 será usado unicamente para mostrar informações mais úteis e precisas no aplicativo.',
                typography: AppTypography.body2,
                color: AppColors.blackLight,
                align: TextAlign.justify,
              ),
              SizedBox(height: 8),
              AppText(
                text:
                    'Esta informação será armazenada somente no seu dispositivo e não será divulgada ao público nem sequer utilizada para  estudos internos ao aplicativo.',
                typography: AppTypography.body2,
                color: AppColors.blackLight,
                align: TextAlign.justify,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button.terciary(
                    size: Size(80, 36),
                    text: 'ENTENDI',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

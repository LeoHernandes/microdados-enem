import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/button/button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/design_system/text_input/text_input.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:microdados_enem_app/onboarding/logic/onboarding_cubit.dart';
import 'package:microdados_enem_app/onboarding/logic/onboarding_state.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/progress_dots.dart';
import 'package:provider/provider.dart';

class StudentVerificationStep extends HookWidget {
  final VoidCallback onNextStep;

  const StudentVerificationStep({super.key, required this.onNextStep});

  @override
  Widget build(BuildContext context) {
    final subscriptionController = useTextEditingController();
    final isValid = useState(true);

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
                      child: BlocBuilder<OnboardingStateCubit, OnboardingState>(
                        builder: (context, state) {
                          return TextInput(
                            disable: state.isLoading || state.isSuccess,
                            controller: subscriptionController,
                            label:
                                state.isSuccess
                                    ? 'Número encontrado'
                                    : 'Número de inscrição',
                            error:
                                state.isError
                                    ? 'Número de inscrição não encontrado'
                                    : !isValid.value
                                    ? 'Insira um número de inscrição'
                                    : null,
                            isSuccess: state.isSuccess,
                            inputType: TextInputType.number,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    AppIconButton(
                      onTap: () => _showSubscriptionNumberExplanation(context),
                      icon: Icons.question_mark,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BlocBuilder<OnboardingStateCubit, OnboardingState>(
                  builder: (context, state) {
                    final localStorage = Provider.of<LocalStorage>(
                      context,
                      listen: false,
                    );

                    if (state.isSuccess) {
                      return Button.primary(
                        size: Size(160, 36),
                        onPressed: () async {
                          await localStorage.setString(
                            StorageKeys.subscription,
                            subscriptionController.text,
                          );
                          onNextStep();
                        },
                        text: 'Continuar',
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button.secondary(
                          size: Size(160, 36),
                          onPressed: onNextStep,
                          text: 'PULAR',
                          disable: state.isLoading,
                        ),
                        Button.primary(
                          size: Size(160, 36),
                          onPressed: () async {
                            if (subscriptionController.text.isEmpty) {
                              isValid.value = false;
                              return;
                            }
                            isValid.value = true;
                            await context
                                .read<OnboardingStateCubit>()
                                .postSubscriptionValidate(
                                  subscriptionController.text,
                                );
                          },
                          text: 'VERIFICAR',
                          loading: state.isLoading,
                        ),
                      ],
                    );
                  },
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
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
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

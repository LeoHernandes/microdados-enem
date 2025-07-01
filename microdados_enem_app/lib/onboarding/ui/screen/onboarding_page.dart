import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:microdados_enem_app/onboarding/logic/onboarding_cubit.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/select_profile_step.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/student_success_step.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/student_verification_step.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/teacher_success_step.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/warning_step.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/welcome_step.dart';
import 'package:microdados_enem_app/core/routes.dart';
import 'package:provider/provider.dart';

enum OnboardingStep {
  Welcome,
  Warning,
  SelectProfile,
  StudentVerification,
  StudentSuccess,
  TeacherSuccess,
}

class OnboardingPage extends HookWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final step = useState(OnboardingStep.Welcome);
    final localStorage = Provider.of<LocalStorage>(context, listen: false);

    return PopScope(
      canPop: step.value == OnboardingStep.Welcome,
      onPopInvokedWithResult:
          (_, _) => {step.value = _previousStep(step.value)},
      child: Scaffold(
        backgroundColor: AppColors.whitePrimary,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 56,
            ),
            child: switch (step.value) {
              OnboardingStep.Welcome => WelcomeStep(
                onNextStep: () => step.value = OnboardingStep.Warning,
              ),
              OnboardingStep.Warning => WarningStep(
                onNextStep: () => step.value = OnboardingStep.SelectProfile,
              ),
              OnboardingStep.SelectProfile => SelectProfileStep(
                onNextStep:
                    (profile) => switch (profile) {
                      ProfileType.student =>
                        step.value = OnboardingStep.StudentVerification,
                      ProfileType.teacher =>
                        step.value = OnboardingStep.TeacherSuccess,
                    },
              ),
              OnboardingStep.StudentVerification => BlocProvider(
                create: (_) => OnboardingStateCubit(),
                child: StudentVerificationStep(
                  onNextStep: () {
                    step.value = OnboardingStep.StudentSuccess;
                  },
                ),
              ),
              OnboardingStep.StudentSuccess => StudentSuccessStep(
                onNextStep: () async {
                  await localStorage.setBool(
                    StorageKeys.isOnboardingComplete,
                    true,
                  );
                  Navigator.pushNamed(context, Routes.home);
                },
              ),
              OnboardingStep.TeacherSuccess => TeacherSuccessStep(
                onNextStep: () async {
                  await localStorage.setBool(
                    StorageKeys.isOnboardingComplete,
                    true,
                  );
                  Navigator.pushNamed(context, Routes.home);
                },
              ),
            },
          ),
        ),
      ),
    );
  }

  OnboardingStep _previousStep(OnboardingStep step) {
    return switch (step) {
      OnboardingStep.Welcome => OnboardingStep.Welcome,
      OnboardingStep.Warning => OnboardingStep.Welcome,
      OnboardingStep.SelectProfile => OnboardingStep.Warning,
      OnboardingStep.StudentVerification => OnboardingStep.SelectProfile,
      OnboardingStep.StudentSuccess => OnboardingStep.StudentVerification,
      OnboardingStep.TeacherSuccess => OnboardingStep.SelectProfile,
    };
  }
}

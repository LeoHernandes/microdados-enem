import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/onboarding/ui/widgets/welcome_step.dart';

enum OnboardingStep {
  Welcome,
  Warning,
  SelectProfile,
  StudentInfo,
  TeacherInfo,
}

class OnboardingPage extends HookWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final step = useState(OnboardingStep.Welcome);

    return Scaffold(
      body: switch (step.value) {
        OnboardingStep.Welcome => WelcomeStep(
          onNextStep: () => step.value = OnboardingStep.Warning,
        ),
        OnboardingStep.Warning => Text('Warning'),
        OnboardingStep.SelectProfile => Text('SelectProfile'),
        OnboardingStep.StudentInfo => Text('StudentInfo'),
        OnboardingStep.TeacherInfo => Text('TeacherInfo'),
      },
    );
  }
}

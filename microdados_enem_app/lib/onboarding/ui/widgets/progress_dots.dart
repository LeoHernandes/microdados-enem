import 'package:flutter/material.dart';
import 'package:microdados_enem_app/design_system/styles/colors.dart';

class ProgressDots extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const ProgressDots({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalSteps,
        (index) => Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                currentStep == index
                    ? AppColors
                        .blueDarker // Active step
                    : AppColors.blackLighter, // Inactive step
          ),
        ),
      ),
    );
  }
}

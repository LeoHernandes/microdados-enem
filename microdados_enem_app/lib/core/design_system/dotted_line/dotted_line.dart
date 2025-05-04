import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';

class DottedDivider extends StatelessWidget {
  final double dotRadius;
  final double spacing;
  final double dashWidth;

  const DottedDivider({
    super.key,
    this.dotRadius = 2.0,
    this.spacing = 4.0,
    this.dashWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (2 * dotRadius + spacing)).floor();

        return SizedBox(
          width: boxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return Container(
                width: dashWidth,
                height: dashWidth,
                decoration: BoxDecoration(
                  color: AppColors.blackLighter,
                  borderRadius: BorderRadius.circular(dotRadius),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

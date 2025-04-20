import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';

class AppCard extends StatelessWidget {
  final Widget body;
  final bool shadow;
  final bool border;

  const AppCard({
    super.key,
    required this.body,
    this.border = false,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: this.border ? Border.all(color: AppColors.bluePrimary) : null,
        color: AppColors.whitePrimary,
        boxShadow:
            this.shadow
                ? [
                  BoxShadow(
                    color: AppColors.blackLightest,
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  ),
                ]
                : null,
      ),

      child: body,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';

class AppCard extends StatelessWidget {
  final Widget body;
  final bool shadow;
  final bool border;
  final double? height;
  final Color? backgroundColor;

  const AppCard({
    super.key,
    required this.body,
    this.border = false,
    this.shadow = false,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width,
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: this.border ? Border.all(color: AppColors.bluePrimary) : null,
        color: backgroundColor ?? AppColors.whitePrimary,
        boxShadow:
            this.shadow
                ? [
                  BoxShadow(
                    color: AppColors.blackPrimary.withAlpha(50),
                    offset: Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 1.5,
                  ),
                ]
                : null,
      ),

      child: body,
    );
  }
}

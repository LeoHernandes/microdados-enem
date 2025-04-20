import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;

  const AppIconButton({super.key, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: onTap,
      disabledColor: AppColors.blackLight,
      icon: Icon(icon),
      color: AppColors.bluePrimary,
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          color: onTap != null ? AppColors.bluePrimary : AppColors.blackLight,
        ),
      ),
    );
  }
}

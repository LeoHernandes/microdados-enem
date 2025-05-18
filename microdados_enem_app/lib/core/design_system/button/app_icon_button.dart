import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final bool border;
  final double? iconSize;
  final String? tooltip;
  final double? size;

  const AppIconButton({
    super.key,
    this.onTap,
    required this.icon,
    this.border = true,
    this.iconSize,
    this.tooltip,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (border) {
      return IconButton.outlined(
        constraints:
            size != null
                ? BoxConstraints(minHeight: size!, minWidth: size!)
                : null,
        tooltip: tooltip,
        iconSize: iconSize,
        onPressed: onTap,
        padding: EdgeInsets.all(0),
        disabledColor: AppColors.blackLight,
        icon: Icon(icon),
        color: AppColors.bluePrimary,
        style: IconButton.styleFrom(
          side: BorderSide(
            color: onTap != null ? AppColors.bluePrimary : AppColors.blackLight,
          ),
        ),
      );
    } else {
      return IconButton.filled(
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: AppColors.whitePrimary,
        ),
        iconSize: iconSize,
        onPressed: onTap,
        icon: Icon(icon),
        color: AppColors.bluePrimary,
        disabledColor: AppColors.blackLight,
      );
    }
  }
}
